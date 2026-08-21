extends Node2D
class_name  Bullet

@onready var timer: Timer = %Timer
@export var BULLET_SPEED: = 1
@export var damage:int = 1


var direction: Vector2

func _ready():
	timer.timeout.connect(bullet_dissapearing)
	rotation = direction.angle()

func move_bullet(delta):
	position += direction * BULLET_SPEED * delta
	

func deal_damage(object, body):
	if object.name == "HurtBox" and body:
		self.queue_free()
		body.HP -= damage
		body.hurt_flush()
		if body is WalkingEnemy:
			body.enemy_hitted.emit(direction)


func bullet_dissapearing():
	var tween = create_tween()
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.2)
	tween.parallel().tween_property(self, "scale", Vector2.ZERO,0.15)
	await tween.finished
	queue_free()
	
