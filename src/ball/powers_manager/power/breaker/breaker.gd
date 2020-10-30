extends "../power.gd"


func activate() -> void:
	owner.set_collision_mask_bit(1, false)
	$Area2D.set_deferred("monitoring", true)
	$Timer.start()
	.activate()


func _deactivate() -> void:
	owner.set_collision_mask_bit(1, true)
	$Area2D.set_deferred("monitoring", false)
	._deactivate()


func _on_Area2D_body_entered(body: Node) -> void:
	body.destroy()


func _on_Timer_timeout() -> void:
	_deactivate()
