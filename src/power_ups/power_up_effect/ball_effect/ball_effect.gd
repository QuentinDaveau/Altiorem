extends "../power_up_effect.gd"


export(int) var AIMED_VELOCITY: int = 1500


func process_state(state: Physics2DDirectBodyState) -> Physics2DDirectBodyState:
	if state.get_contact_count() >= 1:
		var collider := state.get_contact_collider_object(0)
		if collider.is_in_group("bouncer"):
			state = _hit_platform(state, collider)
		if collider.is_in_group("obstacle"):
			_hit_block(collider)
			collider.hit(-state.get_contact_local_normal(0))
		elif collider.has_method("hit"):
			collider.hit()
		_hit_something()
	return state


func _hit_platform(state: Physics2DDirectBodyState, platform: StaticBody2D) -> Physics2DDirectBodyState:
	state.linear_velocity = state.get_contact_local_normal(0) * state.linear_velocity.length()
	if state.linear_velocity.length() < AIMED_VELOCITY:
		state.linear_velocity *= AIMED_VELOCITY / state.linear_velocity.length()
	return state


func _hit_block(block: PhysicsBody2D) -> void:
	pass


func _hit_something() -> void:
	pass
