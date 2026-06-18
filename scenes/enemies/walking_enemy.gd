extends CharacterBody2D
class_name WalkingEnemy

@onready var hurt_box: Area2D = $HurtBox
@onready var hp_label: Label = $HpLabel
#@onready var anim: AnimatedSprite2D

@export var color_flush: Color
@export var color_normal: Color
@export var HP: int = 2
@export var speed: int = 100

var direction: Vector2
var dead = false
#var anim:AnimatedSprite2D

func being(seeing_player_distance: int, anim:AnimatedSprite2D, right:bool):
	if dead:
		HP = 0
		return
	if !is_instance_valid(GameManager.player):
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	
	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < seeing_player_distance:
		direction = (GameManager.player.global_position - self.global_position).normalized()
		velocity = direction * speed
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
		move_and_slide()
	else:
		anim.play("idle")
	hp_label.text = str(HP)
	


func death(anim:AnimatedSprite2D):
	if HP <= 0:
		dead = true
		hp_label.text = str(0)
	hurt_box.queue_free()
	print ("kill")
	anim.play("death")
	await anim.animation_finished
	queue_free()
	GameManager.up_score()
