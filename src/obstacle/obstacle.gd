extends RigidBody2D

signal destroyed(proc_coeff, position)

export(Color) var _break_color: Color
export(int) var _starting_health
export(float, 0, 1) var _power_proc_chance: float = 0.2
export(float) var _camera_shake_amount: float = 1


onready var _current_health: int = _starting_health


#func _ready() -> void:
#	_starting_color = ThemeManager.get_gradient_color(global_position.y)
#
#	_starting_color.v = fmod(_starting_color.v + 0.5, 1)
#	$Polygon2D.color = _starting_color
#	_break_color = _starting_color.darkened(0.5)


func hit() -> void:
	_current_health -= 1
	if _current_health <= 0:
		destroy()
		return
	var health_ratio = 1 - float(_current_health) / _starting_health
	$Polygon2D.color = Color.white.linear_interpolate(_break_color, health_ratio)


func destroy() -> void:
	emit_signal("destroyed", _power_proc_chance, global_position)
	CameraManager.add_shake(_camera_shake_amount)
	$CollisionShape2D.set_deferred("disabled", true)
	$Polygon2D.visible = false
	$Particles2D.emitting = true
	$Timer.start(3)
	yield($Timer, "timeout")
	queue_free()
