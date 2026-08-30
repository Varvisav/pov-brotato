extends Resource
class_name Sound

@export var audio_stream: AudioStream
@export var bus: Bus


const BUS_MAP: Dictionary[Bus, String] = {
	Bus.MUSIC: "Music",
	Bus.LOUD_SFX: "loud sfx",
	Bus.QUIET_SFX: "quiet sfx"
}

enum Bus{
	MUSIC = 0,
	LOUD_SFX = 1,
	QUIET_SFX = 2
}

func get_bus_str():
	return BUS_MAP[bus]