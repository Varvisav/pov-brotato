extends Spawner
class_name BombSpawner

func _on_timer_timeout():
	spawn_enemy(5, 55)

func _process(delta):
	functioning(16, 4.5, 0.16)
