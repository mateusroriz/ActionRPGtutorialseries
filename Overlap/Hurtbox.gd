extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible 

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started") #this could be inside their start functions
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration): # set invicib
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position # - Vector2(0,0)


func _on_Timer_timeout():
	self.invincible = false #needs to have self because we are calling the setter


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)

func _on_Hurtbox_invincibility_ended():
	monitorable = true
