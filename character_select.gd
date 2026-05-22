extends Control



const Asian = preload("res://Images/AsianVolleyBallPlayer.png")
const American = preload("res://Images/AmericanVolleyBallPlayer.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%CharacterPreview.texture = null
	%Music.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_character_1_button_down() -> void:
	%Selected.text= "Selected Taha Jazaeri!"
	%CharacterPreview.texture = American
	%Vine.play() 
	pass # Replace with function body.


func _on_character_2_button_down() -> void:
	%Selected.text= "Selected Ayush Acharya"
	%CharacterPreview.texture = Asian
	%Vine.play() 


	pass # Replace with function body.
