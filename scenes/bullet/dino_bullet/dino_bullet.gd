extends Bullet
class_name DinoBullet

func _process(delta):
	move_bullet(delta)
func _ready():
	bullet_being(4.5)
func _on_area_2_dino_bullet_area_entered(area):
	deal_damage(area, GameManager.player)
	#GameManager.player.hurt_flash()
	
		
