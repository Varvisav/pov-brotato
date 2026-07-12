extends WalkingEnemy
class_name ZombieToast
@onready var anim = $AnimatedSprite2D

func _process(delta):
	if dead:
		HP = 0
		return
	palyer_following(310, anim, true)


func _on_hurt_for_player_body_entered(body):
	if dead:
		return
	if body.name == "CharacterBody2D":
		GameManager.player.HP -=3
		GameManager.player.hurt_flush()


func hurt_flush():
	if dead:
			return
	anim.modulate = color_flush
	await get_tree().create_timer(0.1).timeout
	anim.modulate = color_normal
	if HP <= 0:
			die(anim)
