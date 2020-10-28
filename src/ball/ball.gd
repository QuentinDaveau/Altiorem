extends RigidBody2D

const AIMED_VELOCITY: float = 1500.0
const MAX_HORIZONTAL_ANGLE: float = PI/4.0

var _super_ball: bool = false


func activate_power_up(power_name: String) -> void:
	if power_name == "SuperBall":
		_super_ball = true


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if state.get_contact_count() >= 1:
		var collider = state.get_contact_collider_object(0)
		if collider.get_name() == "Platform":
			state.linear_velocity = state.get_contact_local_normal(0) * state.linear_velocity.length()
			if linear_velocity.length() < AIMED_VELOCITY:
				apply_central_impulse(state.linear_velocity.normalized() * (AIMED_VELOCITY - state.linear_velocity.length()))
		if collider.has_method("hit"):
				collider.hit()
		$AnimationPlayer.play("bounce")
