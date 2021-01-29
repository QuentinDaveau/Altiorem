extends Node2D


const MAX_SPEED: float = 10.0

var _aimed_rotation: float = 0.0


func _physics_process(delta: float) -> void:
	rotation = lerp_angle(rotation, _aimed_rotation, MAX_SPEED * delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		var _screen_position = get_global_transform_with_canvas().get_origin()
		_aimed_rotation = _screen_position.angle_to_point(event.position) + (PI/2.0)
		if abs(_aimed_rotation) > 0.26:
			_aimed_rotation = 0.26 * sign(_aimed_rotation)
