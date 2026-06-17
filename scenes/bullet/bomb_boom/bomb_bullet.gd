extends Bullet
class_name BombBullet

func _process(delta):
	move_bullet(delta)
func _ready():
	bullet_being(0.6)

func _on_area_2d_area_entered(area):
	deal_damage(area, GameManager.player)
	#GameManager.player.hurt_flash()
