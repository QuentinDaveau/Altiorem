extends ColorRect

const ANIM_SPEED: float = 0.4
const ANIM_DELAY: float = 0.1


func _enter_tree() -> void:
	hide()


func appear() -> void:
	show()
	$AnimationPlayer.play("appear")


func _on_ResumeButton_pressed() -> void:
	$AnimationPlayer.play("disappear")
	yield($AnimationPlayer, "animation_finished")
	$RestartTimer.start_delay()
	yield($RestartTimer, "timeout")
	get_tree().paused = false
