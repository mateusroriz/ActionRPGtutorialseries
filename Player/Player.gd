extends KinematicBody2D

const ACCELERATION = 20
const MAX_SPEED = 120
const FRICTION = 10

var velocity = Vector2.ZERO

func _physics_process(delta): ## step event runs every single physics step
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # 1, 0, -1
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	print(velocity)
	move_and_collide(velocity) 
