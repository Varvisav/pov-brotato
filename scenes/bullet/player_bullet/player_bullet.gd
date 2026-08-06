class_name PlayerBullet extends Bullet

func _process(delta):
	move_bullet(delta)

func _on_area_2_dbullet_area_entered(area):
	deal_damage(area, area.get_parent())
