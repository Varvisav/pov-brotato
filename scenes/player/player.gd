class_name Player extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var slow_effect_timer = $SlowTimer
var alive = true
var HP: int = 40

func _input(_event):
	if Input.is_action_just_pressed("shoot"):
		self._shoot()

func _ready():
	GameManager.player = self
	SignalBus.heal.connect(_on_heal)
	

func _physics_process(_delta: float) -> void:
	if alive == false:
		HP = 0
		return
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * GameManager.game_stats.player_speed * GameManager.game_stats.speed_factor
	if direction:
		anim.play("walk")
	else:
		anim.play("idle")
	turn_sprite(direction)
	move_and_slide()
	if GameManager.player.HP <= 0:
		death()
	

func _on_heal(value: int):
	HP += value

func turn_sprite(dir):
	if dir.x < 0:
		anim.flip_h = true
	elif dir.x > 0:
		anim.flip_h = false


func _shoot():
	if alive == false:
		return
	if GameManager.can_shoot == false:
		return
	var mouse_pos: Vector2 = get_global_mouse_position()
	var bullet_dir: Vector2 = (mouse_pos - self.global_position).normalized()

	var bullet: PlayerBullet = bullet_scene.instantiate()
	bullet.direction = bullet_dir
	bullet.global_position = global_position
	bullet.damage *= GameManager.game_stats.damage_factor
	GameManager.spawn_bullet(bullet)

func death():
	alive = false
	anim.play("death")
	await anim.animation_finished
	GameManager.player = null
	var tween = create_tween()
	#await get_tree().create_timer(2).timeout
	tween.tween_property(camera, "zoom", Vector2(5, 5), 300)
	
	GameManager.show_game_over()
	
	
func hurt_flush():
	anim.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.17).timeout
	anim.modulate = Color(1, 1, 1)
	

func slowing_effect():
	GameManager.game_stats.player_speed = GameManager.game_stats.player_speed * 0.55
	slow_effect_timer.start()
	GameManager.hud.slow_effect_label.visible = true
	if GameManager.spider != null:
		GameManager.spider.player_already_slowed = true


func _on_slow_timer_timeout():
	GameManager.game_stats.player_speed = GameManager.game_stats.player_speed / 0.55
	slow_effect_timer.stop()
	GameManager.hud.slow_effect_label.visible = false
	GameManager.spider.player_already_slowed = false
