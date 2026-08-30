class_name LevelUpOption
extends VBoxContainer

@onready var slect_button: Button = %SelectButton
@onready var info_label: Label = %InfoLabel
@onready var cost_label: Label = %CostLabel

var level_up_option_data: LevelUpOptionData

func _ready():
	info_label.text = level_up_option_data.info
	cost_label.text = "cost: " + str(level_up_option_data.cost)
	SignalBus.level_up.connect(_on_level_up)

func _on_level_up(_level_up_enum):
	cost_label.text = "cost: " + str(level_up_option_data.cost)

func _on_select_button_pressed():
	SoundManager.play_sound(SoundManager.BUY_SOUND) 
	SignalBus.level_up.emit(level_up_option_data)
