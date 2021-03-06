extends "../../ball_effect.gd"

onready var _ball = get_tree().get_nodes_in_group("ball")[0]

var _breaking: bool = false
var _bounced_semaphore: int = 0


func process_state(state: Physics2DDirectBodyState) -> Physics2DDirectBodyState:
	if state.linear_velocity.y > -250 and _breaking:
		_disable_breaking()
	if _bounced_semaphore <= 0:
		_bounced_semaphore = 0
		_deactivate()
	return .process_state(state)


func _on_activation() -> void:
	_bounced_semaphore += 1


func _on_refresh() -> void:
	_bounced_semaphore += 1


func _disable_breaking() -> void:
	_bounced_semaphore -= 1
	_breaking = false
	$Particles2D.emitting = false
	$Area2D.set_deferred("monitoring", false)
	_ball.enable_block_collision()


func _hit_platform(state: Physics2DDirectBodyState, platform: StaticBody2D) -> Physics2DDirectBodyState:
	if _breaking:
		return ._hit_platform(state, platform)
	_breaking = true
	_ball.disable_block_collision()
	$Area2D.set_deferred("monitoring", true)
	$Particles2D.emitting = true
	return ._hit_platform(state, platform)


func _on_Area2D_body_entered(body: Node) -> void:
	body.destroy()
