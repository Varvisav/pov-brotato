extends WalkingEnemy
class_name ZombieToast
@onready var anim = $AnimatedSprite2D
@onready var hurt_for_player_timer: Timer = $Timer

var is_player_inside: bool = false

func _process(delta):
	if dead:
		HP = 0
		return
	palyer_following(600, anim, true)
	if HP <= 0:
		die(anim)


func _on_hurt_for_player_body_entered(body):
	if dead:
		return
	if body.name == "CharacterBody2D":
		is_player_inside = true
		GameManager.player.HP -=3
		GameManager.player.hurt_flush()
		hurt_for_player_timer.start()


func hurt_flush():
	if dead:
			return
	anim.modulate = color_flush
	await get_tree().create_timer(0.1).timeout
	anim.modulate = color_normal

func _on_timer_timeout():
	if dead or !is_instance_valid(GameManager.player) or is_player_inside == false:
		return
	GameManager.player.HP -=3
	GameManager.player.hurt_flush()
	if is_player_inside:
		hurt_for_player_timer.start()


func _on_hurt_for_player_body_exited(body: Node2D):
	if dead:
		return
	if body.name == "CharacterBody2D":
		is_player_inside = false
