extends Node

signal score_updated(new_score, break_score_added)


var _height_score: int = 0
var _break_score: int = 0
var _breaks: int = 0


func _ready() -> void:
	CameraManager.observe_camera_position(self, "_on_camera_went_up", true)


func add_target(obstacle: PhysicsBody2D) -> void:
	obstacle.connect("destroyed", self, "_on_obstacle_destroyed",\
		[obstacle.get_score_value()])


func _on_obstacle_destroyed(score_value: int) -> void:
	_break_score += score_value
	_breaks += 1
	emit_signal("score_updated", _height_score + _break_score, score_value)


func _on_camera_went_up(new_height: float) -> void:
	if int(new_height / 10.0) > _height_score:
		_height_score = int(new_height / 10.0)
		emit_signal("score_updated", _height_score + _break_score, 0)
