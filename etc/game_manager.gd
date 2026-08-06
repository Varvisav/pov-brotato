extends Node

#@export var level = Level
var restart_scene = preload("res://scenes/menus/restart.tscn")
var bullets_node: Node
var dino_bullets_node: Node
var player: Player
var zombie_toast: ZombieToast
var dino: Dino
var enemy = [zombie_toast, dino]
var hud: Hud
var spider: Spider
var can_shoot: bool = true
var player_already_slowed: bool = false


var level_up_list: LevelUpList = preload("res://const_data/level_ups.tres")

func _ready() -> void:
	SignalBus.level_up.connect(on_level_up)
	process_mode = PROCESS_MODE_ALWAYS
	SignalBus.shopping_ended.connect(unpause_game)

var player_points: int:
	get:
		return game_stats.player_points
	set(value):
		game_stats.player_points = value
		if value % 7 == 0:
			show_level_up_interface()
	
var game_stats: GameStats = GameStats.new()

func show_game_over():
	var restart = restart_scene.instantiate()
	get_tree().current_scene.add_child(restart)

func start_game():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	#player.HP = 30
	
func quit():
	get_tree().quit()

	
func spawn_bullet(bullet: PlayerBullet):
	bullets_node.add_child(bullet)
	
func spawn_dino_bullet(dinno_bullet: DinoBullet):
	get_tree().current_scene.add_child(dinno_bullet)

func spawn_spider_bullet(spider_bullet: SpiderBullet):
	get_tree().current_scene.add_child(spider_bullet)
	
func spawn_bomb_bullets(bomb_bullet):
	get_tree().current_scene.add_child(bomb_bullet)
	

func player_hurt():
	if player.HP <= 0:
		pass

func up_score():
	player_points += 1


func show_level_up_interface():
	get_tree().paused = true
	var level_up_interface := LevelUpInterface.new_instance(level_up_list.level_ups)
	hud.add_child(level_up_interface)
	

func on_level_up(level_up_data: LevelUpOptionData):
	var cost := level_up_data.cost
	if not game_stats.player_coins >= cost:
		return
	match level_up_data.level_up_enum:
		LevelUpOptionData.LevelUpEnum.DAMAGE_UP:
			game_stats.damage_factor += 0.25
		LevelUpOptionData.LevelUpEnum.SPEED_UP:
			game_stats.speed_factor += 0.25
		LevelUpOptionData.LevelUpEnum.HEALTH_UP:
			SignalBus.heal.emit(8)
		_:
			push_error("level up not implemented")
	game_stats.player_coins -= cost
	level_up_data.cost += 3
	
	

func unpause_game():
	get_tree().paused = false