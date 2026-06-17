extends Spawner
class_name BombSpawner

func _on_timer_timeout():
	spawn_enemy(6, 60)

func _process(delta):
	functioning(20, 2.5, 0.1)
