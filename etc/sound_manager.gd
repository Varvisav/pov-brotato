extends Node

const SHOOT_SOUND:Sound = preload("res://const_data/sounds/shoot_sound.tres")
const RELOAD_SOUND:Sound = preload("res://const_data/sounds/reload_sound.tres")
const COIN_SOUND:Sound = preload("res://const_data/sounds/coin_sound.tres")
const EXPLOSION_SOUND:Sound = preload("res://const_data/sounds/exploud_sound.tres")
const ALARM_SOUND:Sound = preload("res://const_data/sounds/alarm_sound.tres")
const FOOTSTEP_SOUND:Sound = preload("res://const_data/sounds/foot_step_sound.tres")
const BUTTON_SOUND:Sound = preload("res://const_data/sounds/button_sound.tres")
const BUY_SOUND:Sound = preload("res://const_data/sounds/buy_sound.tres")

func play_sound(sound: Sound):
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = sound.audio_stream
	add_child(audio_stream_player)
	audio_stream_player.bus = sound.get_bus_str()
	audio_stream_player.play()
	await audio_stream_player.finished
	audio_stream_player.queue_free()


