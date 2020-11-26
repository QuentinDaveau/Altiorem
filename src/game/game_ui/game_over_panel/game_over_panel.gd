extends ColorRect


func play_game_over() -> void:
	$AnimationPlayer.play("display_game_over")


func _on_RestartButton_pressed() -> void:
	SceneManager.reload_game()


func _on_HomeButton_pressed() -> void:
	SceneManager.load_menu()
