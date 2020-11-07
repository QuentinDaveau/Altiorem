extends "../power.gd"


var _bounced: bool = false


func process_state(state: Physics2DDirectBodyState) -> Physics2DDirectBodyState:
	if _bounced:
		if state.linear_velocity.y > -250:
			_deactivate()
	return .process_state(state)


func _hit_platform(state: Physics2DDirectBodyState, platform: StaticBody2D) -> Physics2DDirectBodyState:
	_bounced = true
	owner.set_collision_mask_bit(1, false)
	$Area2D.set_deferred("monitoring", true)
	$Particles2D.emitting = true
	return ._hit_platform(state, platform)


func _deactivate() -> void:
	_bounced = false
	$Particles2D.emitting = false
	owner.set_collision_mask_bit(1, true)
	$Area2D.set_deferred("monitoring", false)
	._deactivate()


func _on_Area2D_body_entered(body: Node) -> void:
	body.destroy()
