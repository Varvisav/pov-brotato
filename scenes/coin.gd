extends Area2D
class_name Coin


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: Node2D):
	if body is Player:
		GameManager.game_stats.player_coins += 1
		queue_free()
