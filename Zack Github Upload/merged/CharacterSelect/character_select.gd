extends Control

const Asian = preload("res://CharacterSelect/AsianVolleyBallPlayer.png")
const American = preload("res://CharacterSelect/AmericanVolleyBallPlayer.png")

# FIXED: Changed type to AudioStreamPlayer2D to match your scene nodes
var current_music: AudioStreamPlayer2D

# Keeps track of the selected character's name
var selected_character: String = ""

func _ready() -> void:
	%CharacterPreview.texture = null
	
	# Connect the "finished" signals and bind each player node to the callback
	#%Music.finished.connect(_on_music_finished.bind(%Music))
	#%Music2.finished.connect(_on_music_finished.bind(%Music2))
	#
	## Randomly pick either %Music or %Music2 to start playing
	#current_music = [%Music, %Music2].pick_random()
	#current_music.play()

func _process(delta: float) -> void:
	pass

# FIXED: Changed the parameter type here to AudioStreamPlayer2D as well
#func _on_music_finished(finished_player: AudioStreamPlayer2D) -> void:
	## If %Music finished, switch to %Music2. If %Music2 finished, switch to %Music.
	#if finished_player == %Music:
		#current_music = %Music2
	#else:
		#current_music = %Music
		#
	#current_music.play()

# This function picks a random sound from our 5 options
func play_random_sound() -> void:
	var sound_list = [%Vine, %Fah, %Pipe, %Riz, %Wow]
	var random_choice = sound_list.pick_random()
	random_choice.play()

func _on_character_1_button_down() -> void:
	%Selected.text = "Selected Taha Jazaeri!"
	%CharacterPreview.texture = American
	selected_character = "Taha Jazaeri"
	play_random_sound()

func _on_character_2_button_down() -> void:
	%Selected.text = "Selected Ayush Acharya"
	%CharacterPreview.texture = Asian
	selected_character = "Ayush Acharya"
	play_random_sound()


func _on_back_button_pressed() -> void:
	GlobalAudio.play_sfx($ButtonSound.stream)
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
