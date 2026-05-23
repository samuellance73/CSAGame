extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	GlobalAudio.play_sfx($ButtonSound.stream)
	get_tree().change_scene_to_file("res://volleyball_court.tscn")



func _on_exit_pressed() -> void:
	GlobalAudio.play_sfx($ButtonSound.stream)
	get_tree().quit()


func _on_options_pressed() -> void:
	GlobalAudio.play_sfx($ButtonSound.stream)
	get_tree().change_scene_to_file("res://options_screen.tscn")
