extends Spawner
class_name  ZombieToastSpawner
func _on_timer_timeout():
	spawn_enemy(60, 190)

func _process(delta):
	functioning(1, 2.4, 0.045)
