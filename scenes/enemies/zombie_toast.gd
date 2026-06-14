extends CharacterBody2D
class_name ZombieToast
var direction: Vector2
const SPEED: int = 40
var HP: int = 2


@onready var anim = $AnimatedSprite2D
@onready var hp_label: Label= $HpLabel
var dead = false

func _ready():
	pass

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
	
	


func death():
	GameManager.zombie_toast=null
	dead = true
	hp_label.text = str(0)
	anim.play("death")
	await anim.animation_finished
	queue_free()
	GameManager.up_score()



func _on_death_body_entered(body):
	if dead:
			return
	if body.name == "CharacterBody2D":
		GameManager.player_HP -=3
		GameManager.player.hurt_flash()
		


func _on_hurt_box_area_entered(area):
	if dead:
			return
	if area.name == "Area2Dbullet":
		HP = HP - GameManager.players_bullet_damage
		hurt_flash()
		
	if HP <= 0:
		death()
	if dead:
			return
	
	
func hurt_flash():
	if dead:
			return
	anim.modulate = Color(1, 0, 1)
	await get_tree().create_timer(0.1).timeout
	anim.modulate = Color(1,1,1)
