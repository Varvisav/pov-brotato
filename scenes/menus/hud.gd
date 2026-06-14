extends CanvasLayer
@onready var hp_label: Label = $PlayerHpLabel
@onready var points_label: Label = $PlayerPointsLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hp_label.text = "HEALTH: " + str(GameManager.player_HP)
	points_label.text = "KILLS: " + str(GameManager.player_points)


func _on_button_pressed():
	pass # Replace with function body.
