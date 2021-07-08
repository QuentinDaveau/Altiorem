extends "../../ball_effect.gd"


func _on_activation() -> void:
	$LifeTimer.start()


func _on_refresh() -> void:
	$LifeTimer.start()


func _hit_block(block: PhysicsBody2D) -> void:
	for b in $Area2D.get_overlapping_bodies():
		if not b == block:
			b.hit((b.global_position - global_position).normalized())
	CameraManager.add_shake(4)
	$AnimationPlayer.play("explode")


func _on_LifeTimer_timeout() -> void:
	_deactivate()
