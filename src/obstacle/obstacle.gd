extends RigidBody2D


signal destroyed()

export(Color) var _break_color: Color
export(int) var _starting_health
export(float) var _camera_shake_amount: float = 8
export(float, 0, 1) var _power_proc_chance: float = 0.2
export(int, 0, 100) var _score_value: int = 10



onready var _current_health: int = _starting_health


func _ready() -> void:
	for n in get_tree().get_nodes_in_group("obstacle_break_listener"):
		n.add_target(self)


func get_proc_chance() -> float:
	return _power_proc_chance


func get_score_value() -> int:
	return _score_value


func hit() -> void:
	_current_health -= 1
	if _current_health <= 0:
		destroy()
		return
	var health_ratio = 1 - float(_current_health) / _starting_health
	$Polygon2D.color = Color.white.linear_interpolate(_break_color, health_ratio)


func destroy() -> void:
	emit_signal("destroyed")
	CameraManager.add_shake(_camera_shake_amount)
	$CollisionShape2D.set_deferred("disabled", true)
	$Polygon2D.visible = false
	$Particles2D.emitting = true
	$Timer.start(3)
	yield($Timer, "timeout")
	queue_free()
