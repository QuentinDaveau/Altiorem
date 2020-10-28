extends "../power.gd"


func activate() -> void:
	$LifeTimer.start()


func _hit_block(block: PhysicsBody2D) -> void:
	for b in $Area2D.get_overlapping_bodies():
		b.hit()
	$Sprite.visible = true
	$Timer.start()
	yield($Timer, "timeout")
	$Sprite.visible = false


func _deactivate() -> void:
	._deactivate()


func _on_LifeTimer_timeout() -> void:
	_deactivate()
