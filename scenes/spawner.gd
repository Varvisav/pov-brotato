extends Node2D
class_name Spawner
@export var enemies_scenes: Array[PackedScene]

const map_min_x = 25
const  map_max_x = 1160
const map_min_y = 25
const map_max_y = 620

func spawn_enemy():
	if GameManager.player==null:
		return
	
	var random_enemy = enemies_scenes.pick_random()
	var enemy = random_enemy.instantiate()
	var angle = randf_range(0, TAU)
	var radius = randf_range(200,300)
	var spawn_pos = GameManager.player.global_position + Vector2.RIGHT.rotated(angle) * radius
	spawn_pos.x = clamp(spawn_pos.x, map_min_x, map_max_x)
	spawn_pos.y = clamp(spawn_pos.y, map_min_y, map_max_y)
	enemy.global_position =  spawn_pos
	get_tree().current_scene.add_child(enemy)

func _ready():
	pass # Replace with function body.

	


func _on_timer_timeout():
	spawn_enemy()
