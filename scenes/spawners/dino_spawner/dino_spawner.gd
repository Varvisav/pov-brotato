extends Spawner
class_name  DinoSpawner

func _on_timer_timeout():
	spawn_enemy(140, 400)

func _process(delta):
	functioning(15, 1.4, 0.1)
