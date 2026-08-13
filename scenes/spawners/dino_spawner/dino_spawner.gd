extends Spawner
class_name  DinoSpawner

func _on_timer_timeout():
	spawn_enemy(120, 320)

func _process(delta):
	functioning(5, 3.5, 0.14)
