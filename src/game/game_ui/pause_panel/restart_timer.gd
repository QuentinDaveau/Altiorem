extends CenterContainer

signal timeout()


func _enter_tree() -> void:
	hide()


func start_delay() -> void:
	show()
	$AnimationPlayer.play("count_down")
	yield($AnimationPlayer, "animation_finished")
	hide()
	emit_signal("timeout")
