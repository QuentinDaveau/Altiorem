extends Node

signal score_updated(new_score, break_score_added)

var _counting: bool = true
var _height_score: int = 0
var _break_score: int = 0
var _breaks: int = 0


func _ready() -> void:
	CameraManager.observe_camera_position(self, "_on_camera_went_up", true)


func add_target(obstacle: PhysicsBody2D) -> void:
	obstacle.connect("destroyed", self, "_on_obstacle_destroyed",\
		[obstacle.get_score_value()])


func fix_score() -> Dictionary:
	_counting = false
	var new_score = _height_score + _break_score
	var scores: Array = DataManager.get_data("scores", [])
	var ratios := _generate_ratios(scores, new_score)
	
	if new_score > 0:
		scores.append(new_score)
		DataManager.add_data("scores", scores)
		DataManager.add_data("points", DataManager.get_data("points", 0) + ratios["points"])
	return ratios


func _generate_ratios(scores: Array, new_score: int) -> Dictionary:
	var mean: int = 0
	var best: int = scores.max() if scores.max() else 0
	for s in scores:
		mean += s
	mean = mean / scores.size() if scores.size() > 0 else mean
	return {"best": best, "mean": mean, "score": new_score, "points": floor(float(new_score) / 100)}


func _on_obstacle_destroyed(score_value: int) -> void:
	if not _counting:
		return
	_break_score += score_value
	_breaks += 1
	emit_signal("score_updated", _height_score + _break_score, score_value)


func _on_camera_went_up(new_height: float) -> void:
	if not _counting:
		return
	if int(new_height / 10.0) > _height_score:
		_height_score = int(new_height / 10.0)
		emit_signal("score_updated", _height_score + _break_score, 0)
