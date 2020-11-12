extends Camera2D

const SHAKE_THRESHOLD: float = 0.5
const SHAKE_DAMP: float = 0.7
const SHAKE_NOISE: float = 0.1
const SHAKE_SPEED: float = 0.03

signal went_up(new_position)
signal went_up_distance(new_position)

export(bool) var _shake_enabled: bool = true

onready var _default_offset: Vector2 = offset
onready var _old_height: float = get_camera_screen_center().y
onready var _start_height: float = get_camera_screen_center().y

var _shake_amount: Vector2 = Vector2.ZERO


func _ready() -> void:
	set_drag_margin(MARGIN_BOTTOM, 3.0)
	randomize()


func _physics_process(_delta: float) -> void:
	var height := get_camera_screen_center() + _default_offset - offset
	if height.y < _old_height:
		emit_signal("went_up", height.y)
		emit_signal("went_up_distance", abs(height.y - _start_height))


func add_shake(amount: float) -> void:
	if not _shake_enabled:
		return
	var vec_amount := (Vector2(randf(), randf()) - Vector2(0.5, 0.5)) * 2.0 * amount
	if sign(_shake_amount.x):
		_shake_amount.x += abs(vec_amount.x) * sign(_shake_amount.x)
	else:
		_shake_amount.x += vec_amount.x
	if sign(_shake_amount.y):
		_shake_amount.y += abs(vec_amount.y) * sign(_shake_amount.y)
	else:
		_shake_amount.y += vec_amount.y
	_shake()


func _shake() -> void:
	$Shaker.interpolate_property(self, "offset", offset, _shake_amount + _default_offset,\
			SHAKE_SPEED, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	$Shaker.start()


func _on_Shaker_tween_all_completed() -> void:
	if not _shake_amount:
		return
	_shake_amount = (-_shake_amount * (1 - SHAKE_DAMP)).rotated(
			rand_range(-PI/2 * SHAKE_NOISE, PI/2 * SHAKE_NOISE))
	if _shake_amount.length() < SHAKE_THRESHOLD:
		_shake_amount = Vector2.ZERO
	_shake()
