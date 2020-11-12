extends Node2D


func _ready() -> void:
	CameraManager.observe_camera_position(self, "_on_camera_went_up")


func _on_camera_went_up(new_height: float) -> void:
	global_position.y = new_height
