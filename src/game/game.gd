extends Node


func _on_FallDetector_ball_fell(ball: RigidBody2D) -> void:
	ball.sleeping = true
	ball.set_deferred("mode", ball.MODE_STATIC)
	$GameUI.disable_pause_button()
	CameraManager.add_shake(100)
	yield(get_tree().create_timer(0.75), "timeout")
	$GameUI.play_game_over($ScoreManager.fix_score())


func _start_game() -> void:
	pass


func _pause_game() -> void:
	pass
