extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@export var leftControl : String
@export var rightControl : String
@export var upControl : String
@export var downControl : String

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	#get
	var x_speed := Input.get_axis(leftControl, rightControl)
	var y_speed := Input.get_axis(upControl, downControl)
	
	
	
	if x_speed:
		velocity.x = x_speed * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if y_speed:
		velocity.y = y_speed * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	
	
	move_and_slide()
