extends Spawner
class_name BombSpawner

func _on_timer_timeout():
	spawn_enemy(4, 55)

func _process(delta):
	functioning(8, 4.6, 0.1)
