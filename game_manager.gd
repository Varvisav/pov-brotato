extends Node

@export var level = Level
var restart_scene = preload("res://scenes/menus/restart.tscn")
var bullets_node: Node
var dino_bullets_node: Node
var player: Player
var zombie_toast: ZombieToast
var dino: Dino
var enemy = [zombie_toast, dino]
var hud: Hud

	
var player_speed: int = 160
#var player_HP= player.HP
var player_points: int = 0
#var players_bullet_damage = 1

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
	#dino_bullets_node.add_child(dinno_bullet)
	get_tree().current_scene.add_child(dinno_bullet)
	
func spawn_bomb_bullets(bomb_bullet):
	get_tree().current_scene.add_child(bomb_bullet)
	

func player_hurt():
	if player.HP <=0:
		pass

func up_score():
	player_points += 1
	
	
