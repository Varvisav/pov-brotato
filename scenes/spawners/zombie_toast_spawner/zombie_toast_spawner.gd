extends Spawner
class_name  ZombieToastSpawner
func _on_timer_timeout():
	spawn_enemy(70, 300)

func _process(delta):
	functioning(5, 2.0, 0.07)
