extends ColorRect

const SPEED_ON_CLICK: float = 2.0


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch && $AnimationPlayer.is_playing():
		$AnimationPlayer.playback_speed = SPEED_ON_CLICK
		$Control/ScoreGauge.set_playback_speed(SPEED_ON_CLICK)


func play_game_over(score: int, mean: int, best: int, points: int) -> void:
	$AnimationPlayer.playback_speed = 1.0
	$Control/ScoreGauge.set_playback_speed(1.0)
	$ScoreLabel.bbcode_text = "[center]" + String(score) + "[/center]"
	$PointsLabel.bbcode_text = "[center]" + String(points) + "[/center]"
	$Control/ScoreGauge.set_scores(score, mean, best)
	$AnimationPlayer.play("display_game_over")


func _on_RestartButton_pressed() -> void:
	SceneManager.reload_game()


func _on_HomeButton_pressed() -> void:
	SceneManager.load_menu()
