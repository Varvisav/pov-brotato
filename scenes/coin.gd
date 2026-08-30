extends Area2D
class_name Coin
var seeing_player_distance: int = 59
var speed: int = 74
var direction: Vector2
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	magnetick_effect()
	global_position += velocity * delta

func magnetick_effect():
	if !is_instance_valid(GameManager.player):
		velocity = Vector2.ZERO
		return

	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < seeing_player_distance:
		direction = (GameManager.player.global_position - self.global_position).normalized()

		var current_speed = speed * (1 - (distance / seeing_player_distance))

		velocity = direction * current_speed
	else:
		velocity = Vector2.ZERO
		
	
		


func _on_body_entered(body: Node2D):
	if body is Player:
		SoundManager.play_sound(SoundManager.COIN_SOUND)
		GameManager.game_stats.player_coins += 1
		queue_free()

