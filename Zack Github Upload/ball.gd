extends RigidBody2D

@onready var area2d: Area2D = $Area2D
@export var HITSPEED := 200
@onready var hit_timer: Timer = $"hit timer"
var inAir = false
@onready var alpha_area: Area2D = $AlphaArea

signal hitGround(source)

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size_lerp(Vector2(0.5, 0.5), 0.0, 0)
	$countingTimer.start()
	hit_timer.wait_time = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !(body is CharacterBody2D): 
		return
	var direction = position.direction_to(body.position)
	var dir_to_zero = position.direction_to(Vector2(0,0))
	print(str(dir_to_zero))
	
	linear_velocity = -direction * HITSPEED
	linear_velocity.x = (-direction.x*0.2 + dir_to_zero.x) * HITSPEED
	linear_velocity.y = (-direction.y*0.5 + dir_to_zero.y * 0.1) * HITSPEED
	
	linear_velocity += body.velocity
	
	hit()
	
	### TODO ###
	# Change Alpha when over player

func hit():
	area2d.set_collision_layer_value(1, false)
	area2d.set_collision_mask_value(1, false)
	
	hit_timer.start()
	size_lerp(Vector2(1,1), hit_timer.wait_time/2, 1)
	
	await get_tree().create_timer(hit_timer.wait_time/2).timeout
	
	size_lerp(Vector2(.5,.5), hit_timer.wait_time/2, -1)

func size_lerp(size, wait_time, dir):
	var tween = create_tween()
	
	# Scale the visual sprite
	if dir == 1:
		tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		inAir = true
	elif dir == -1:
		tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		groundCheck()
	elif dir == 0:
		tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	
	
	tween.tween_property($Sprite2D, "scale", size, wait_time)
	# Scale the collision dashape simultaneously
	tween.parallel().tween_property($CollisionShape2D, "scale", size, wait_time)

func alpha_lerp(alpha, wait_time):
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", alpha, wait_time)

func _on_hit_timer_timeout() -> void:
	
	area2d.set_collision_layer_value(1, true)
	area2d.set_collision_mask_value(1, true)

func groundCheck():
	await get_tree().create_timer(1.25).timeout
	inAir = false
	
	if !inAir:
		#wait 0.5s
		await get_tree().create_timer(0.25).timeout
		#if still on ground
		if !inAir:
			hitGround.emit(self)
			print("ball hit ground")

func _on_alpha_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	alpha_lerp(0.5, .1)


func _on_alpha_area_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	alpha_lerp(1, .1)


#func _on_counting_timer_timeout() -> void:
	#time += 1
	#
	#if time < 10:
		#$"hit timer".wait_time = 2.25
		#HITSPEED += 25
	#elif time < 20:
		#$"hit timer".wait_time = 2
		#HITSPEED += 25
	#elif time < 30:
		#$"hit timer".wait_time = 1.75
		#HITSPEED += 25
	#elif time < 40:
		#$"hit timer".wait_time = 1.5
		#HITSPEED += 25
	#elif time < 50:
		#$"hit timer".wait_time = 1.25
		#HITSPEED += 25
	#else:
		#$"hit timer".wait_time = 1
		#HITSPEED += 25
	
