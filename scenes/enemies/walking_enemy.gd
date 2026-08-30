extends CharacterBody2D
class_name WalkingEnemy

signal enemy_hitted(direction: Vector2)
@onready var hurt_box: Area2D = $HurtBox
@onready var hp_label: Label = $HpLabel
#@onready var anim: AnimatedSprite2D

@export var color_flush: Color
@export var color_normal: Color
@export var HP: int = 2:
	set(value):
		HP = max(value,0)

@export var speed: int = 100
@export var coin_scene: PackedScene

var direction: Vector2
var dead = false
var inertia: Vector2 = Vector2.ZERO
#var anim:AnimatedSprite2D

func _ready():
	enemy_hitted.connect(_on_enemy_hitted)

func palyer_following(seeing_player_distance: int, anim:AnimatedSprite2D, right:bool):
	if dead:
		HP = 0
		return
	if !is_instance_valid(GameManager.player):
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	inertia = inertia.lerp(Vector2.ZERO, 0.08)
	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < seeing_player_distance:
		direction = (GameManager.player.global_position - self.global_position).normalized()
		velocity = direction * speed + inertia
		if direction:
			anim.play("walk")
		
		if right:
			if direction.x < 0:
				anim.flip_h = false
			elif direction.x >0:
				anim.flip_h = true
		else:
			if direction.x < 0:
				anim.flip_h = true
			elif direction.x >0:
				anim.flip_h = false
		if distance > 20:
			move_and_slide()
	else:
		anim.play("idle")
	hp_label.text = str(HP)
	
func _on_enemy_hitted(bullet_direction: Vector2):
	inertia = bullet_direction * 110

func die(anim:AnimatedSprite2D):
	if dead:
		return
	dead = true
	hp_label.text = str(0)
	hurt_box.queue_free()
	anim.play("death")
	await anim.animation_finished
	var coin = coin_scene.instantiate()
	coin.global_position = global_position
	get_parent().add_child(coin)
	queue_free()
	GameManager.up_score()
	
