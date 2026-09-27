class_name Player extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var slow_effect_timer: Timer = $SlowTimer
@onready var reload_timer: Timer = $ReloadTimer
@onready var footstep_timer: Timer = %FootStepsTimer

var direction: Vector2 = Vector2.ZERO
var alive = true:
	set(value):
		if value == alive:
			return
		alive = value
		if not alive:
			die()
var HP: int = 40:
	get():
		if alive:
			return HP
		return 0
	set(value):
		HP=value
		if HP <=0:
			alive = false
var bullets_count: int = 40:
	set(value):
		bullets_count=value
		if value == 0:
			reload_start()

func _ready():
	GameManager.player = self
	SignalBus.heal.connect(_on_heal)
	reload_timer.timeout.connect(reload_finish)

func _input(_event):
	direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_just_pressed("shoot"):
		self._shoot()

func _process(_delta: float) -> void:
	if alive:
		anim_move()
	if velocity != Vector2.ZERO and footstep_timer.is_stopped():
		footstep_timer.start()
		SoundManager.play_sound(SoundManager.FOOTSTEP_SOUND, GameManager.game_stats.speed_factor)
			

func _physics_process(_delta: float) -> void:
	if not alive:
		return
	move()
	

func move():
	velocity = direction * GameManager.game_stats.player_speed * GameManager.game_stats.speed_factor
	move_and_slide()
	turn_sprite(direction)

func anim_move():
	if direction != Vector2.ZERO:
		if GameManager.player_already_slowed:
			anim.play("slow_walk")
		else:
			anim.play("walk")
	else:
		footstep_timer.stop()
		anim.play("idle")


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
	bullet.damage = roundi(bullet.damage * GameManager.game_stats.damage_factor)
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
			var sound_timer = Timer.new()	
			sound_timer.wait_time = 1.4
			sound_timer.one_shot = true
			sound_timer.autostart = true
			add_child(sound_timer)
			await sound_timer.timeout
			sound_timer.queue_free()
		


func reload_finish():
	bullets_count = 40
	GameManager.hud.reload_icon.visible = false
	GameManager.hud.player_bullets_label.visible = true



func die():
	footstep_timer.stop()
	anim.play("die")
	print ("animation")
	await anim.animation_finished
	print ("animation finished")
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
