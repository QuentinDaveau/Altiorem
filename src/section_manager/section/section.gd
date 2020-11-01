extends Node2D

func get_obstacles() -> Array:
	var obstacles := []
	for o in $Obstacles.get_children():
		obstacles.append(o)
	return obstacles
