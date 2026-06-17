extends CanvasLayer
class_name Hud
@onready var hp_label: Label = $PlayerHpLabel
@onready var points_label: Label = $PlayerPointsLabel

#var player_helth = GameManager.player_HP

func _process(_delta):
	if !is_instance_valid(GameManager.player):
		hp_label.text = "HEALTH: 0"
	else:
		hp_label.text = "HEALTH: " + str(GameManager.player.HP)
		points_label.text = "KILLS: " + str(GameManager.player_points)


func _on_button_pressed():
	pass # Replace with function body.
