extends Resource
class_name LevelUpOptionData

@export var info: String
@export var level_up_enum: LevelUpEnum
@export var icon:Texture2D

enum LevelUpEnum{
    SPEED_UP,
    HEALTH_UP,
    DAMAGE_UP
}

