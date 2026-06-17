extends Node2D
class_name  Bullet

@export var BULLET_SPEED: = 1
@export var damage:int = 1

var direction: Vector2

func move_bullet(delta):
	position += direction * BULLET_SPEED * delta
	

func deal_damage(object, body):
	if object.name == "HurtBox":
		self.queue_free()
		body.HP -= damage
		body.hurt_flush()

func bullet_being(dissapear_time:float):
	rotation = direction.angle()
	await get_tree().create_timer(dissapear_time).timeout
	var tween = create_tween()
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.2)
	tween.parallel().tween_property(self, "scale", Vector2.ZERO,0.15)
	await tween.finished
	queue_free()
	
