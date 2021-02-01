extends StaticBody2D


func hit() -> void:
	$AnimationPlayer.play("bounce")
