extends Area2D

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0 #return true if we are colliding with something
	
func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = areas[0] #getting the first area we are colliding
		push_vector = area.global_position.direction_to(global_position) #getting a vector that goes from its position to our position
		push_vector = push_vector.normalized()
	return push_vector #return zero if we are not colliding
