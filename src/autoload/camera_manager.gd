extends Node

var _camera: Camera2D


func add_shake(amount: float) -> void:
	_camera.add_shake(amount)


func observe_camera_position(node: Node, function: String, distance: bool = false) -> void:
	if not is_instance_valid(_camera):
		if not _search_camera():
			return
	if not distance:
		_camera.connect("went_up", node, function)
	else:
		_camera.connect("went_up_distance", node, function)


func _search_camera() -> bool:
	_camera = get_tree().get_nodes_in_group("camera")[0]
	return _camera != null
