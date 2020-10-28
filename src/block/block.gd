extends StaticBody2D

signal destroyed(proc_coeff, position)

export(Color) var _starting_color: Color
export(Color) var _break_color: Color
export(int) var _starting_health
export(float, 0, 1) var _power_proc_chance: float = 0.2


onready var _current_health: int = _starting_health


func _ready() -> void:
	$Polygon2D.color = _starting_color


func hit() -> void:
	_current_health -= 1
	if _current_health <= 0:
		destroy()
		return
	var health_ratio = 1 - float(_current_health) / _starting_health
	$Polygon2D.color = _starting_color.linear_interpolate(_break_color, health_ratio)


func destroy() -> void:
	emit_signal("destroyed", _power_proc_chance, position)
	queue_free()
