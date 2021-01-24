extends ColorRect


func play_game_over(score: int, mean: int, best: int, points: int) -> void:
	$ScoreLabel.bbcode_text = "[center]" + String(score) + "[/center]"
	$PointsLabel.bbcode_text = "[center]" + String(points) + "[/center]"
	$Control/ScoreGauge.set_scores(score, mean, best)
	$AnimationPlayer.play("display_game_over")


func _on_RestartButton_pressed() -> void:
	SceneManager.reload_game()


func _on_HomeButton_pressed() -> void:
	SceneManager.load_menu()
