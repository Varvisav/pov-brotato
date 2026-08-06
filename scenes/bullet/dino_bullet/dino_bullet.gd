extends Bullet
class_name DinoBullet

func _process(delta):
	move_bullet(delta)

func _on_area_2_dino_bullet_area_entered(area):
	deal_damage(area, GameManager.player)

	
		
