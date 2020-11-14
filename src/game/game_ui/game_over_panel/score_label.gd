extends RichTextLabel


func set_score(score_value: int) -> void:
	bbcode_text = "[center]" + String(score_value) + "[/center]"
