extends CanvasLayer
class_name Hud
@onready var hp_label: Label = $PlayerHpLabel
@onready var coins_label: Label = $PlayerCointsLabel
@onready var slow_effect_label: Label = $SlowEffectLabel
@onready var pause_button: Button = %PauseButton
@onready var player_bullets_label: Label = %PlayerBulletsLabel
@onready var reload_icon: Node2D = %ReloadIcon
@onready var timer_label: Label = %TimerLabel

var pause_is_holding_down:bool = false



func _ready() -> void:
	GameManager.hud = self
	pause_button.pressed.connect(_on_paused_button_pressed)
	
func _process(_delta):
	if !is_instance_valid(GameManager.player):
		hp_label.text = ": 0"
	else:
		hp_label.text = ": " + str(GameManager.player.HP)
		coins_label.text = ": " + str(GameManager.game_stats.player_coins)
		slow_effect_label.text = "SLOW EFFECT: " + str(int(GameManager.player.slow_effect_timer.time_left)) + "s"
		player_bullets_label.text = ": " + str(GameManager.player.bullets_count)
		timer_label.text = str(int(ceil(GameManager.level_up_timer.time_left))) + "s"

func _on_paused_button_pressed():
	get_tree().paused = not get_tree().paused

func _on_button_mouse_entered():
	GameManager.can_shoot = false

func _on_button_mouse_exited():
		GameManager.can_shoot = true
 
