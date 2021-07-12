extends RigidBody2D

const HIT_SHAKE_STRENGTH: float = 8.0
const HIT_SHAKE_TIME: float = 0.06


signal destroyed()

export(Color) var _break_color: Color
export(int) var _starting_health
export(float) var _camera_shake_amount: float = 8
export(float, 0, 1) var _power_proc_chance: float = 0.2
export(int, 0, 100) var _score_value: int = 10


onready var _current_health: int = _starting_health

var _destroyed: bool = false


func _ready() -> void:
	for n in get_tree().get_nodes_in_group("obstacle_break_listener"):
		n.add_target(self)


func get_proc_chance() -> float:
	return _power_proc_chance


func get_score_value() -> int:
	return _score_value


func hit(hit_dir: Vector2 = Vector2.ZERO) -> void:
	if _destroyed:
		return
	_current_health -= 1
	if _current_health <= 0:
		destroy(hit_dir)
		return
	var health_ratio = 1 - float(_current_health - 1) / _starting_health
	_play_hit(hit_dir)
	$Polygon2D.color = Color.white.linear_interpolate(_break_color, health_ratio)


func destroy(hit_dir: Vector2 = Vector2.UP) -> void:
	if _destroyed:
		return
	_destroyed = true
	emit_signal("destroyed")
	CameraManager.add_shake(_camera_shake_amount)
	$CollisionShape2D.set_deferred("disabled", true)
	$Polygon2D.visible = false
	$Particles2D.color = _break_color
	$Particles2D.global_rotation = hit_dir.angle() + PI/2
	$Particles2D.emitting = true
	$Timer.start(3)
	yield($Timer, "timeout")
	queue_free()


func _play_hit(hit_dir: Vector2) -> void:
	if !hit_dir: 
		return
	$Tween.stop_all()
	$Tween.interpolate_property($Polygon2D, "position", $Polygon2D.position, \
			$Polygon2D.position + hit_dir * HIT_SHAKE_STRENGTH, HIT_SHAKE_TIME, \
			Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.interpolate_property($Polygon2D, "position", $Polygon2D.position + hit_dir * HIT_SHAKE_STRENGTH, \
			Vector2.ZERO, HIT_SHAKE_TIME, \
			Tween.TRANS_CUBIC, Tween.EASE_IN, HIT_SHAKE_TIME)
	$Tween.start()

