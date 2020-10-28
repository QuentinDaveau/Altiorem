extends Line2D

const MAX_LENGTH: int = 5


func _physics_process(delta: float) -> void:
	global_position = Vector2.ZERO
	global_rotation = 0.0
	add_point(owner.global_position)
	
	while get_point_count() > MAX_LENGTH:
		remove_point(0)
