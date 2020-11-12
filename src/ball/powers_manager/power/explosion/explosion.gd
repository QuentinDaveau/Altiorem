extends "../power.gd"


func activate() -> void:
	$LifeTimer.start()


func _hit_block(block: PhysicsBody2D) -> void:
	for b in $Area2D.get_overlapping_bodies():
		b.hit()
	CameraManager.add_shake(5)
	$AnimationPlayer.play("explode")


func _deactivate() -> void:
	._deactivate()


func _on_LifeTimer_timeout() -> void:
	_deactivate()
