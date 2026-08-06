extends Bullet
class_name BombBullet

func _process(delta):
	move_bullet(delta)

func _on_area_2d_area_entered(area):
	deal_damage(area, area.get_parent())#GameManager.player)
	#GameManager.player.hurt_flash()
