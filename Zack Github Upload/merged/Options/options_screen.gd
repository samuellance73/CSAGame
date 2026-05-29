extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/MusicBoxContainer/MusicSlider.value = GlobalAudio.get_volume("Music 2")
	$HBoxContainer/SFXBoxContainer/SFXSlider.value = GlobalAudio.get_volume("SFX")

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_pressed() -> void:
	GlobalAudio.play_sfx($ButtonSound.stream)
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn") # Replace with function body.


func _on_music_slider_value_changed(value: float) -> void:
	GlobalAudio.set_volume("Music 2", value)


func _on_sound_slider_value_changed(value: float) -> void:
	GlobalAudio.set_volume("SFX", value)
