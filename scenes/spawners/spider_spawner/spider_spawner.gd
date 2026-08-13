extends Spawner

func _on_timer_timeout():
	spawn_enemy(120, 320)

func _process(delta):
	functioning(6, 3.0, 0.12)