extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 125
export var FRICTION = 500

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats #acessing global singleton for player stats

onready var animationPlayer = $AnimationPlayer 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback") #getting acess to the animations in the animation tree
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtboxes

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free") #connecting to own queue_free
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	
	
func _physics_process(delta): ## step event runs every single physics step
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			roll_state(delta)
			
		ATTACK:
			attack_state(delta)
			
	
func move_state(delta): 
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # 1, 0, -1
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO: # we are moving
		roll_vector = input_vector #should be here so it isn't zero when it's not moving
		swordHitbox.knockback_vector = input_vector # knockbackvector will be the same as the direction we are moving in
		
		animationTree.set("parameters/Idle/blend_position", input_vector) #set the bland position for the idle 
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector) # has to be here because we have access to input vector
		animationTree.set("parameters/Roll/blend_position", input_vector) # has to be here because we have access to input vector
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("Roll_input"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack_input"):
		state = ATTACK

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED * 1.5 # goes instantily to max speed
	animationState.travel("Roll")
	move()

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func move():
	velocity = move_and_slide(velocity) 
	

func roll_animation_finished():
	velocity = velocity * 0.5 #this is to kill the slide or not after the roll
	state = MOVE

func attack_animation_finished():
	state = MOVE


func _on_Hurtboxes_area_entered(area):
	stats.health -= 1
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()
