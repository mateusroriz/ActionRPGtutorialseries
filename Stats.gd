extends Node

export(int) var max_health = 1
onready var health = max_health setget set_health #setting the health everytime the value changes


signal no_health


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
