extends Node2D


func create_grass_effect():
	var GrassEffect = load("res://Effects/GrassEffect.tscn") #loading the scene
	var grassEffect = GrassEffect.instance() #this is a instance of the scene
	var world = get_tree().current_scene # getting the acess to tree of the main scene
	world.add_child(grassEffect) 
	grassEffect.global_position = global_position #setting the grass effect position to the grass position it was on


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
