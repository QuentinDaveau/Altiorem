extends "../../ball_effect.gd"

const UP_SCALE: float = 3.0

onready var _ball = get_tree().get_nodes_in_group("ball")[0]


func _on_activation() -> void:
	$Area2D.set_deferred("monitoring", true)
	_ball.disable_block_collision()
	_ball.change_scale(UP_SCALE)
	$LifeTimer.start()


func _on_refresh() -> void:
	$LifeTimer.start()


func _on_deactivation() -> void:
	$Area2D.set_deferred("monitoring", false)
	_ball.enable_block_collision()
	_ball.reset_scale()


func _hit_something() -> void:
	CameraManager.add_shake(10)


func _on_LifeTimer_timeout() -> void:
	_deactivate()


func _on_Area2D_body_entered(body: Node) -> void:
	CameraManager.add_shake(5)
	$Ray.play_effect(body.global_position)
	body.destroy((body.global_position - global_position).normalized())
