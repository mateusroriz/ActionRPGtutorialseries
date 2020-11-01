extends Area2D

var player = null 

func can_see_player():
	return player != null #return true or false based on wheter or not is inside detection zone


func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(_body):
	player = null
