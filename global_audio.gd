extends Node

@onready var sfx_player := AudioStreamPlayer.new()
@onready var music_player := AudioStreamPlayer.new()

func _ready():
	add_child(sfx_player)
	add_child(music_player)

	sfx_player.bus = "SFX"
	music_player.bus = "Music"

func play_music(stream: AudioStream):
	music_player.stream = stream
	music_player.play()

func play_sfx(stream: AudioStream):
	sfx_player.stream = stream
	sfx_player.play()
	
func set_volume(bus_name: String, linear_value: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var db_value = linear_to_db(linear_value)
	
	AudioServer.set_bus_volume_db(bus_index, db_value)
	
func get_volume(bus_name: String) -> float:
	var bus_index = AudioServer.get_bus_index(bus_name)
	var db_value = AudioServer.get_bus_volume_db(bus_index)
	
	return db_to_linear(db_value)
	
	
