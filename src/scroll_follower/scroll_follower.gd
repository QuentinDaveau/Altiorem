extends Node2D


export(NodePath) var _camera_path: NodePath

onready var _target_camera = get_node(_camera_path)


func _physics_process(delta: float) -> void:
	global_position = _target_camera.get_camera_screen_center()
