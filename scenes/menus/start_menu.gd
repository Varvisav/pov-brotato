extends VBoxContainer

@onready var start_button = $StartButton

func _ready():
	start_button.pressed.connect(on_start_button_pressed)
	
func on_start_button_pressed():
	GameManager.start_game()


#func _on_quit_button_pressed():
	#GameManager.quit()
