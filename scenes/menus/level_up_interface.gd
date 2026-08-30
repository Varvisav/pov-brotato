class_name LevelUpInterface
extends Control

@onready var level_up_options: HBoxContainer = %levelUpOptions
@export var level_up_option_scene: PackedScene
@onready var end_shopping_button: Button = %EndShoppingButton
const level_up_interface_scene: PackedScene = preload("res://scenes/menus/level_up_interface.tscn")

var options: Array[LevelUpOptionData]

func _ready() -> void:
	SignalBus.shopping_ended.connect(_on_shopping_ended)
	end_shopping_button.pressed.connect(on_end_shopping_button_pressed)

	for option: LevelUpOptionData in options:
		var level_up_option: LevelUpOption = level_up_option_scene.instantiate()
		level_up_option.level_up_option_data = option
		level_up_options.add_child(level_up_option)

func _process(delta):
	pass

func on_end_shopping_button_pressed():
	SoundManager.play_sound(SoundManager.BUTTON_SOUND)
	SignalBus.shopping_ended.emit()

static func new_instance(level_up_options: Array[LevelUpOptionData]) -> LevelUpInterface:
	var level_up_interface: LevelUpInterface = level_up_interface_scene.instantiate()
	level_up_interface.options = level_up_options
	return level_up_interface


func _on_shopping_ended():
	self.queue_free()
