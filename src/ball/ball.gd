extends RigidBody2D


func activate_power(power_name: String) -> void:
	$PowersManager.activate(power_name)


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	state = $PowersManager.process_state(state)
	if state.get_contact_count() >= 1:
		$AnimationPlayer.play("bounce")
