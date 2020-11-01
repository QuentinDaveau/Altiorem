extends Node


func _on_FallDetector_ball_fell(ball: RigidBody2D) -> void:
	ball.sleeping = true
	ball.set_deferred("mode", ball.MODE_STATIC)
	CameraManager.add_shake(50)
	print("game over")
