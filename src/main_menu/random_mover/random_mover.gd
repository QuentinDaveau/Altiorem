extends Node2D

export(int) var _max_dist: int = 64
export(float) var _travel_time: float = 8.0
export(float) var _time_variation: float = 2.0


func _ready() -> void:
	randomize()
	_interpolate("position:x")
	_interpolate("position:y")


func _interpolate(property: String) -> void:
	$Tween.interpolate_property(self, property, get(property), rand_range(- _max_dist, _max_dist),\
			_travel_time + rand_range(- _time_variation, _time_variation),\
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(_object: Object, key: NodePath) -> void:
	_interpolate(key)
