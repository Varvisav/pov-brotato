extends CharacterBody2D
class_name Bomb

@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var timer_label: Label= $TimerLabel
@onready var timer = $Timer
var dead = false
var bullets_count = 64

func boom():
	if !is_instance_valid(GameManager.player):
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	anim.play("boom")
	dead = true
	await anim.animation_finished
	queue_free()
	for i in bullets_count:
		var angle = i * TAU / bullets_count
		var bullet_dir = Vector2.RIGHT.rotated(angle)
		var bullet = bullet_scene.instantiate()
		bullet.direction = bullet_dir
		bullet.global_position = global_position
		GameManager.spawn_bomb_bullets(bullet)

func _physics_process(delta):
	if dead:
		return
	if !is_instance_valid(GameManager.player):
		anim.play("idle")
		return
	timer_label.text = str(int(timer.time_left))


func _on_timer_timeout():
	boom()
