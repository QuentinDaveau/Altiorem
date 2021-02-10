extends Node2D


func play_effect(position_to_aim: Vector2) -> void:
	global_rotation = position_to_aim.angle_to_point(global_position)
	$RayPoly.visible = true
	$CPUParticles2D.emitting = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	$CPUParticles2D.emitting = false
	$RayPoly.visible = false
