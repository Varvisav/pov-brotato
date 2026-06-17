extends CharacterBody2D
class_name ZombieToast
var direction: Vector2
const SPEED: int = 30
var HP: int = 2

@onready var hurt_box: Area2D = $HurtBox
@onready var anim = $AnimatedSprite2D
@onready var hp_label: Label= $HpLabel
var dead = false


func _physics_process(delta):
	if dead:
		return
	if !is_instance_valid(GameManager.player):
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	
	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < 250:
		direction = (GameManager.player.global_position - self.global_position).normalized()
		velocity = direction * SPEED
		if direction:
			anim.play("walk")
			
		if direction.x < 0:
			anim.flip_h = false
		elif direction.x >0:
			anim.flip_h = true
		move_and_slide()
	else:
		anim.play("idle")
	hp_label.text = str(HP)
	#move_and_slide()
	if HP <= 0:
		death()


func death():
	GameManager.zombie_toast=null
	dead = true
	hp_label.text = str(0)
	hurt_box.queue_free()
	anim.play("death")
	await anim.animation_finished
	queue_free()
	GameManager.up_score()


func _on_death_body_entered(body):
	if dead:
			return
	if body.name == "CharacterBody2D":
		GameManager.player.HP -=2
		GameManager.player.hurt_flush()
	
	
func hurt_flush():
	if dead:
			return
	anim.modulate = Color(1, 0, 1)
	await get_tree().create_timer(0.1).timeout
	anim.modulate = Color(1,1,1)
