extends "../../power_up_effect.gd"


func _on_activation() -> void:
	$AnimationPlayer.play("bar_up")
	$LifeTimer.start()


func _on_refresh() -> void:
	$LifeTimer.start()


func _on_deactivation() -> void:
	$AnimationPlayer.play("bar_down")


func _on_Timer_timeout() -> void:
	_deactivate()
