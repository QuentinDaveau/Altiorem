extends Node2D

signal deactivated(this)

const MAX_HORIZONTAL_ANGLE: float = PI/4.0

export(int) var AIMED_VELOCITY: int = 1500


func activate() -> void:
	pass


func process_state(state: Physics2DDirectBodyState) -> Physics2DDirectBodyState:
	if state.get_contact_count() >= 1:
		var collider := state.get_contact_collider_object(0)
		if collider.get_name() == "Platform":
			_hit_platform(state, collider)
		if collider.is_in_group("obstacle"):
			_hit_block(collider)
	return state


func _hit_platform(state: Physics2DDirectBodyState, platform: StaticBody2D) -> Physics2DDirectBodyState:
	state.linear_velocity = state.get_contact_local_normal(0) * state.linear_velocity.length()
	if state.linear_velocity.length() < AIMED_VELOCITY:
		owner.apply_central_impulse(state.linear_velocity.normalized() * (AIMED_VELOCITY - state.linear_velocity.length()))
	platform.hit()
	return state


func _hit_block(block: PhysicsBody2D) -> void:
	block.hit()


func _deactivate() -> void:
	emit_signal("deactivated", self)
