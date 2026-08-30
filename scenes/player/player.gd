class_name Player extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var slow_effect_timer: Timer = $SlowTimer
@onready var reload_timer: Timer = $ReloadTimer
@onready var footstep_timer: Timer = %FootStepsTimer
var alive = true
var HP: int = 40
var bullets_count: int = 40:
	set(value):
		bullets_count=value
		if value == 0:
			reload_start()



func _input(_event):
	if Input.is_action_just_pressed("shoot"):
		self._shoot()


func _ready():
	GameManager.player = self
	SignalBus.heal.connect(_on_heal)
	reload_timer.timeout.connect(reload_finish)

func _physics_process(_delta: float) -> void:
	if alive == false:
		HP = 0
		return
	if GameManager.player_already_slowed:
		moving_and_animations("slow_walk", "idle")
	else:
		moving_and_animations("walk", "idle")
	#if reload_timer.is_stopped() == false:
		#moving_and_animations("reload", "reload")
	#else:
		#moving_and_animations("walk", "idle")
	#elif Input.is_action_just_pressed("reload"):
		#reload_start()
	

func moving_and_animations(walking, idle):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * GameManager.game_stats.player_speed * GameManager.game_stats.speed_factor
	if direction:
		anim.play(walking)
		if footstep_timer.is_stopped():
			SoundManager.play_sound(SoundManager.FOOTSTEP_SOUND)
			footstep_timer.start()
			
	else:
		footstep_timer.stop()
	
		anim.play(idle)
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
	if bullets_count <= 0:
		return
	SoundManager.play_sound(SoundManager.SHOOT_SOUND)
	var mouse_pos: Vector2 = get_global_mouse_position()
	var bullet_dir: Vector2 = (mouse_pos - self.global_position).normalized()
	var bullet: PlayerBullet = bullet_scene.instantiate()
	bullet.direction = bullet_dir
	bullet.global_position = global_position
	bullet.damage *= GameManager.game_stats.damage_factor
	GameManager.spawn_bullet(bullet)
	bullets_count -= 1

func reload_start():
	reload_timer.start()
	GameManager.hud.reload_icon.visible = true
	GameManager.hud.player_bullets_label.visible = false
	GameManager.hud.reload_icon.anim.play("reload")
	if reload_timer.is_stopped() == false:
		while reload_timer.time_left > 0:
			SoundManager.play_sound(SoundManager.RELOAD_SOUND)			
			await get_tree().create_timer(1.4).timeout
		


func reload_finish():
	bullets_count = 40
	GameManager.hud.reload_icon.visible = false
	GameManager.hud.player_bullets_label.visible = true



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
	if GameManager.player_already_slowed:
		return
	GameManager.game_stats.player_speed = GameManager.game_stats.player_speed * 0.55
	footstep_timer.wait_time += 0.1
	slow_effect_timer.start()
	GameManager.hud.slow_effect_label.visible = true
	if GameManager.spider != null:
		GameManager.player_already_slowed = true
	anim.play("slow_walk")
	
func _on_slow_timer_timeout():
	GameManager.game_stats.player_speed = GameManager.game_stats.player_speed / 0.55
	footstep_timer.wait_time -= 0.1
	slow_effect_timer.stop()
	GameManager.hud.slow_effect_label.visible = false
	GameManager.player_already_slowed = false


func _on_foot_steps_timer_timeout():
	SoundManager.play_sound(SoundManager.FOOTSTEP_SOUND)
