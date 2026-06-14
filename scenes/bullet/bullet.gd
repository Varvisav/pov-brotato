class_name Bullet extends Node2D
var direction: Vector2
const BULLET_SPEED: = 200

func _process(delta):
	position += direction * BULLET_SPEED * delta
func _ready():
	rotation = direction.angle()
	await get_tree().create_timer(4.0).timeout
	queue_free()


func _on_area_2_dbullet_area_entered(area):
	
	if area.name == "HurtBox":
		#if !is_instance_valid(GameManager.zombie_toast)
			#return
		#if !is_instance_valid(GameManager.dino):
			#return
		self.queue_free()
