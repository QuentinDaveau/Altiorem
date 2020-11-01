extends Node

onready var _camera: Camera2D = get_tree().get_nodes_in_group("camera")[0]


func add_shake(amount: float) -> void:
	_camera.add_shake(amount)


func observe_camera_position(node: Node, function: String) -> void:
	_camera.connect("went_up", node, function)
