extends Node2D
class_name Spawner
@export var enemies_scene: PackedScene
@onready var timer = $Timer

const map_min_x = 25
const  map_max_x = 1160
const map_min_y = 25
const map_max_y = 620

#enemy_scene
func spawn_enemy(min_range, max_range):
	if GameManager.player==null:
		return

	var enemy = enemies_scene.instantiate()
	var angle = randf_range(0, TAU)
	var radius = randf_range(min_range,max_range)
	var spawn_pos = GameManager.player.global_position + Vector2.RIGHT.rotated(angle) * radius
	spawn_pos.x = clamp(spawn_pos.x, map_min_x, map_max_x)
	spawn_pos.y = clamp(spawn_pos.y, map_min_y, map_max_y)
	enemy.global_position =  spawn_pos
	get_tree().current_scene.add_child(enemy)

var last_threshold =0 
func functioning(points_number, timer_min: float, removed_seconds: float):
	var threshold = GameManager.player_points / points_number
	if threshold >last_threshold:
		last_threshold=threshold
		timer.wait_time = max(timer_min, timer.wait_time - removed_seconds)
