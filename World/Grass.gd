extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("attack_input"):
		var GrassEffect = load("res://Effects/GrassEffect.tscn") #loading the scene
		var grassEffect = GrassEffect.instance() #this is a instance of the scene
		var world = get_tree().current_scene # getting the acess to tree of the main scene
		world.add_child(grassEffect) 
		grassEffect.global_position = global_position #setting the grass effect position to the grass position it was on
		queue_free()
