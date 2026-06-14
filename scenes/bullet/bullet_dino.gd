extends Node2D
class_name DinoBullet

var direction: Vector2
const BULLET_SPEED: = 250

func _process(delta):
	position += direction * BULLET_SPEED * delta
func _ready():
	rotation = direction.angle()
	await get_tree().create_timer(5.0).timeout
	queue_free()



func _on_area_2_dino_bullet_body_entered(body):
	if body.name == "CharacterBody2D":
		GameManager.player_HP -=3
		GameManager.player.hurt_flash()
		self.queue_free()
