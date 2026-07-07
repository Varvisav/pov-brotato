class_name LevelUpOption
extends VBoxContainer

@onready var slect_button: Button = %SelectButton
@onready var info_label: Label = %InfoLabel

var level_up_option_data: LevelUpOptionData

func _ready():
	info_label.text = level_up_option_data.info


func _on_select_button_pressed():
	SignalBus.level_up.emit(level_up_option_data.level_up_enum)
