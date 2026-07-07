class_name LevelUpInterface
extends Control

@onready var level_up_options: HBoxContainer = %levelUpOptions
@export var level_up_option_scene: PackedScene
const level_up_interface_scene: PackedScene = preload("res://scenes/menus/level_up_interface.tscn")

var options: Array[LevelUpOptionData] 


static func new_instance(level_up_options:Array[LevelUpOptionData]) -> LevelUpInterface:
	var level_up_interface: LevelUpInterface = level_up_interface_scene.instantiate()
	level_up_interface.options = level_up_options
	return level_up_interface

func _ready():
	for option: LevelUpOptionData in options:
		var level_up_option: LevelUpOption = level_up_option_scene.instantiate()
		level_up_option.level_up_option_data=option
		level_up_options.add_child(level_up_option)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
