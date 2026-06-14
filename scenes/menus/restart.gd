extends CanvasLayer
class_name RestartHud

@onready var kills_label: Label = $KILLS

func _ready():
	pass 



func _process(delta):
	kills_label.text = "YOUR KILLS: " + str(GameManager.player_points)


func _on_button_pressed():
	GameManager.start_game()
