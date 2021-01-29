extends RigidBody2D

var _disable_semaphore: int = 0


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	state = $BallPowerUpReceiver.process_state(state)
	if state.get_contact_count() >= 1:
		$AnimationPlayer.play("bounce")


func disable_block_collision() -> void:
	_disable_semaphore += 1
	set_collision_mask_bit(1, false)


func enable_block_collision() -> void:
	_disable_semaphore -= 1
	if _disable_semaphore <= 0:
		set_collision_mask_bit(1, true)
