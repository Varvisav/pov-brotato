extends CharacterBody2D
class_name Dino
var direction: Vector2
const SPEED: int = 50
var HP: int = 2
var dead = false
@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var hp_label: Label= $HpLabel


func _ready():
	pass
func shoot():
	if dead:
			return
	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < 200:
		var viewport_center: Vector2 = get_viewport().get_window().size / 2
		var bullet_dir: Vector2 = (GameManager.player.global_position - self.global_position).normalized()

		var bullet = bullet_scene.instantiate()
		bullet.direction = bullet_dir
		bullet.global_position = global_position
		GameManager.spawn_dino_bullet(bullet)
		



func _physics_process(delta):
	if dead:
		return
	if !is_instance_valid(GameManager.player):
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	
	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < 300:
		direction = (GameManager.player.global_position - self.global_position).normalized()
		velocity = direction * SPEED
		if direction:
			anim.play("walk")
			
		if direction.x < 0:
			anim.flip_h = true
		elif direction.x >0:
			anim.flip_h = false
		move_and_slide()
	else:
		anim.play("idle")
	hp_label.text = str(HP)
	#move_and_slide()
	






func death():
	GameManager.dino=null
	dead = true
	hp_label.text = str(0)
	anim.play("death")
	await anim.animation_finished
	queue_free()
	GameManager.up_score()

func hurt_flush():
	if dead:
			return
	anim.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.1).timeout
	anim.modulate = Color(1,1,1)
	
	

func _on_timer_timeout():
	if dead:
			return
	if GameManager.player != null:
		shoot()


func _on_hurt_box_area_exited(area):
	if dead:
			return
	if area.name == "Area2Dbullet":
		HP = HP - GameManager.players_bullet_damage
		hurt_flush()
	if HP <= 0:
		death()
