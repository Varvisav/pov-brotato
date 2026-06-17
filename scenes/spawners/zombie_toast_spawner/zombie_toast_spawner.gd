extends Spawner
class_name  ZombieToastSpawner
func _on_timer_timeout():
	spawn_enemy(80, 290)

func _process(delta):
	functioning(10, 1.0, 0.2)
