extends Area2D

signal ball_fell(ball)

func _on_FallDetector_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		emit_signal("ball_fell", body)
