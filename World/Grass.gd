extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")#loading the scene

func create_grass_effect():
	var grassEffect = GrassEffect.instance() #this is a instance of the scene
	get_parent().add_child(grassEffect) 
	grassEffect.global_position = global_position #setting the grass effect position to the grass position it was on


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
