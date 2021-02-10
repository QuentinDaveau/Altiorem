extends "../../power_up_effect.gd"

onready var _score_manager = get_tree().get_nodes_in_group("score_manager")[0]


func _on_activation() -> void:
	_score_manager.set_multiplier(2)
	$LifeTimer.start()


func _on_refresh() -> void:
	$LifeTimer.start()


func _on_deactivation() -> void:
	_score_manager.reset_multiplier()


func _on_Timer_timeout() -> void:
	_deactivate()
