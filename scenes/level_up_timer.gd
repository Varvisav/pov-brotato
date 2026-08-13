extends Timer
class_name LevelUpTimer
var added_time: int:
	get:
		return GameManager.game_stats.level_ups_count * 5

func _ready():
	SignalBus.shopping_ended.connect(restart_timer)
	GameManager.level_up_timer = self


func _process(delta):
	pass

func restart_timer():
	start(30 + added_time)

func _on_timeout():
	SignalBus.level_up_timer_timeout.emit()
