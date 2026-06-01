extends Control

const CHARACTERS = {
	"character1": {
		"id": "American",
		"display_name": "American Ahh",
		"texture": preload("res://CharacterSelect/AmericanVolleyBallPlayer.png"),
		"stats": "Speed: ★★★★☆  |  Jump: ★★★☆☆  |  Power: ★★★★★"
	},
	"character2": {
		"id": "Asian",
		"display_name": "Asian Kid",
		"texture": preload("res://CharacterSelect/AsianVolleyBallPlayer.png"),
		"stats": "Speed: ★★★★★  |  Jump: ★★★★☆  |  Power: ★★☆☆☆"
	},
	"character3": {
		"id": "Indian",
		"display_name": "Selected Indian Kid!",
		"texture": preload("res://CharacterSelect/IndianPlayer.png"),
		"stats": "Speed: ★★★☆☆  |  Jump: ★★★★★  |  Power: ★★★☆☆"
	},
	"character4": {
		"id": "Ginger",
		"display_name": "Ginger Ahh",
		"texture": preload("res://CharacterSelect/GingerPlayer.png"),
		"stats": "Speed: ★★★★☆  |  Jump: ★★★☆☆  |  Power: ★★★★☆"
	}
}

var current_music: AudioStreamPlayer2D
var selected_character: String = ""

var preview_start_pos: Vector2
var preview_default_scale: Vector2
var bob_tween: Tween
var active_button_name: String = ""

func _ready() -> void:
	%CharacterPreview.texture = null
	preview_start_pos = %CharacterPreview.position
	preview_default_scale = %CharacterPreview.scale
	%CharacterPreview.pivot_offset = %CharacterPreview.size / 2
	
	%Selected.pivot_offset = %Selected.size / 2
	
	for button in $HBoxContainer.get_children():
		if button is Button and button.name in CHARACTERS:
			button.pivot_offset = button.size / 2
			
			button.mouse_entered.connect(_on_button_hover.bind(button))
			button.mouse_exited.connect(_on_button_unhover.bind(button))
			button.pressed.connect(_on_character_selected.bind(button.name))
			
	_play_scene_entry_animation()

func _play_scene_entry_animation() -> void:
	$HBoxContainer.scale = Vector2(0.85, 0.85)
	$HBoxContainer.modulate.a = 0.0
	$HBoxContainer.pivot_offset = $HBoxContainer.size / 2
	
	var entry_tween = create_tween().set_parallel(true)
	entry_tween.tween_property($HBoxContainer, "scale", Vector2.ONE, 0.6).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	entry_tween.tween_property($HBoxContainer, "modulate:a", 1.0, 0.4)

func _on_button_hover(button: Control) -> void:
	button.pivot_offset = button.size / 2
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(button, "scale", Vector2(1.08, 1.08), 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "rotation", deg_to_rad(-5.0), 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	if button.name != active_button_name:
		tween.tween_property(button, "modulate", Color(0.9, 0.9, 0.95), 0.15)
		
	if has_node("ButtonSound"):
		var tick_player = AudioStreamPlayer.new()
		add_child(tick_player)
		tick_player.stream = $ButtonSound.stream
		tick_player.volume_db = -15
		tick_player.pitch_scale = 1.5 
		tick_player.play()
		tick_player.finished.connect(tick_player.queue_free)

func _on_button_unhover(button: Control) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(button, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "rotation", 0.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	if button.name != active_button_name:
		tween.tween_property(button, "modulate", Color.WHITE, 0.15)

func _on_character_selected(button_name: String) -> void:
	var data = CHARACTERS[button_name]
	
	%Selected.text = data["display_name"] + "\n" + data["stats"]
	%CharacterPreview.texture = data["texture"]
	selected_character = data["id"]
	active_button_name = button_name
	
	play_random_sound()
	play_selection_animation()
	_highlight_active_button(button_name)
	_play_text_pop_animation()

func _play_text_pop_animation() -> void:
	%Selected.pivot_offset = %Selected.size / 2
	%Selected.scale = Vector2(0.85, 0.85)
	
	var tween = create_tween()
	tween.tween_property(%Selected, "scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _highlight_active_button(active_name: String) -> void:
	for button in $HBoxContainer.get_children():
		if button.name in CHARACTERS:
			var tween = create_tween().set_parallel(true)
			if button.name == active_name:
				tween.tween_property(button, "modulate", Color(1.0, 0.85, 0.2), 0.15)
			else:
				tween.tween_property(button, "modulate", Color.WHITE, 0.15)
				tween.tween_property(button, "scale", Vector2.ONE, 0.15)
				tween.tween_property(button, "rotation", 0.0, 0.15)
				
func play_random_sound() -> void:
	var sound_list = [%Vine, %Fah, %Pipe, %Riz, %Wow, %hR]
	var random_choice = sound_list.pick_random()
	
	random_choice.pitch_scale = randf_range(0.7, 1.5)
	random_choice.play()

func play_selection_animation() -> void:
	if bob_tween:
		bob_tween.kill()
	
	%CharacterPreview.scale = preview_default_scale * 0.5
	%CharacterPreview.position.y = preview_start_pos.y + 20.0
	%CharacterPreview.rotation = 0.0
	
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(%CharacterPreview, "scale", preview_default_scale, 0.55).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(%CharacterPreview, "position:y", preview_start_pos.y, 0.55).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(%CharacterPreview, "rotation", TAU, 0.55).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween.chain().tween_callback(start_idle_bobbing)

func start_idle_bobbing() -> void:
	if bob_tween:
		bob_tween.kill()
		
	%CharacterPreview.rotation = 0.0
	
	bob_tween = create_tween().set_loops()
	bob_tween.tween_property(%CharacterPreview, "position:y", preview_start_pos.y - 10.0, 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bob_tween.tween_property(%CharacterPreview, "position:y", preview_start_pos.y, 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_back_button_pressed() -> void:
	if bob_tween:
		bob_tween.kill()
	GlobalAudio.play_sfx($ButtonSound.stream)
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
