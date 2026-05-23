extends StaticBody2D

@onready var ball: RigidBody2D = $Ball

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
		print(area)
		if area.is_in_group("ball"):
			b = true
			print("inside")
	if !b:
		print("out")
