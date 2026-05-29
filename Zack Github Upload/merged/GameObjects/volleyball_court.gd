extends StaticBody2D

@onready var ball: RigidBody2D = $Ball
@onready var debug_label: Label = $debugLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_sfx($WhistleSound.stream)
	ball.hitGround.connect(_hit_ground)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _hit_ground(source):
	var areas = $boundsArea.get_overlapping_areas()
	var b = false
	for area in areas:
		if area.is_in_group("ball"):
			b = true
			debug_label.text = "inside hit"
			print("inside")
			
			if area.global_position.x < 0:
				#addScore.emit(1, 2)
				Signals.playerScored.emit(1, 2)
				print(area.global_position.x)
			else:
				#addScore.emit(1, 1)
				Signals.playerScored.emit(1, 1)
				print(area.global_position.x)
			
			
	if !b:
		debug_label.text = "outside hit"
		print("outside")
