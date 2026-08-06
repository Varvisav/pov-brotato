extends Bullet
class_name SpiderBullet

func _process(delta):
	move_bullet(delta)


func _on_area_2d_body_entered(body: Node2D):
	if body.name == "CharacterBody2D":
		GameManager.player.slowing_effect()
		self.queue_free()