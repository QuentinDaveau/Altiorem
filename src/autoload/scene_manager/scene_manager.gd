extends CanvasLayer


func load_menu() -> void:
	return
	_load_scene("res://src/menu/MainMenu.tscn")


func load_game() ->void:
	_load_scene("res://src/game/Game.tscn")


func reload_game() -> void:
	_load_scene()


func _load_scene(scene_path: String = "") -> void:
	$AnimationPlayer.play("transition_enter")
	yield($AnimationPlayer, "animation_finished")
	if scene_path:
		assert(get_tree().change_scene(scene_path) == OK)
	else:
		assert(get_tree().reload_current_scene() == OK)
	$AnimationPlayer.play("transition_exit")
	yield($AnimationPlayer, "animation_finished")
