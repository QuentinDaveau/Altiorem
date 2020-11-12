extends CanvasLayer


func _on_ScoreManager_score_updated(new_score: int, break_score_added: int) -> void:
	# To do: add point effect if break_score_added
	$UIRoot/MarginContainer/HBoxContainer/RichTextLabel.bbcode_text = "[right]" + String(new_score) + "[/right]"
