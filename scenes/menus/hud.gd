extends CanvasLayer
class_name Hud
@onready var hp_label: Label = $PlayerHpLabel
@onready var coins_label: Label = $PlayerCointsLabel
@onready var slow_effect_label: Label = $SlowEffectLabel
var pause_is_holding_down:bool = false
#var player_helth = GameManager.player_HP


func _ready() -> void:
	GameManager.hud = self

func _process(_delta):
	if !is_instance_valid(GameManager.player):
		hp_label.text = "HEALTH: 0"
	else:
		hp_label.text = "HEALTH: " + str(GameManager.player.HP)
		coins_label.text = "COINS: " + str(GameManager.game_stats.player_coins)
		slow_effect_label.text = "SLOW EFFECT: " + str(int(GameManager.player.slow_effect_timer.time_left)) + "s"


func _on_button_pressed():
	get_tree().paused = not get_tree().paused

func _on_button_mouse_entered():
	GameManager.can_shoot = false


func _on_button_mouse_exited():
		GameManager.can_shoot = true
