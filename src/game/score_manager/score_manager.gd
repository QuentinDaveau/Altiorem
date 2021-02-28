extends Node

signal score_updated(new_score, break_score_added)

var _counting: bool = true
var _height_score: int = 0
var _bonus_height_score: int = 0
var _break_score: int = 0
var _breaks: int = 0
var _multiplier: int = 1


func _ready() -> void:
	CameraManager.observe_camera_position(self, "_on_camera_went_up", true)


func add_target(obstacle: PhysicsBody2D) -> void:
	obstacle.connect("destroyed", self, "_on_obstacle_destroyed",\
		[obstacle.get_score_value()])


func fix_score() -> Dictionary:
	_counting = false
	var new_score = _height_score + _bonus_height_score + _break_score
	var scores: Array = DataManager.get_data("scores", [])
	var ratios := _generate_ratios(scores, new_score)
	
	if new_score > 0:
		scores.append(new_score)
		DataManager.add_data("scores", scores)
		DataManager.add_data("points", DataManager.get_data("points", 0) + ratios["points"])
		DataManager.add_data("best", ratios["best"])
		DataManager.add_data("mean", ratios["mean"])
		DataManager.add_data("games", scores.size())
		
		if _height_score > DataManager.get_data("max_height", 0):
			DataManager.add_data("max_height", _height_score)
		
		if _breaks > DataManager.get_data("max_breaks", 0):
			DataManager.add_data("max_breaks", _breaks)
		
	return ratios


func set_multiplier(multiplier_value: int) -> void:
	_multiplier = multiplier_value


func reset_multiplier() -> void:
	_multiplier = 1


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
	_break_score += score_value * _multiplier
	_breaks += 1
	emit_signal("score_updated", _height_score + _bonus_height_score + _break_score, score_value)


func _on_camera_went_up(new_height: float) -> void:
	if not _counting:
		return
	if int(new_height / 10.0) > _height_score:
		var new_height_score := int(new_height / 10.0)
		if _multiplier > 1:
			_bonus_height_score += int((new_height_score - _height_score) * (_multiplier - 1))
		_height_score = new_height_score
		emit_signal("score_updated", _height_score + _bonus_height_score + _break_score, 0)
