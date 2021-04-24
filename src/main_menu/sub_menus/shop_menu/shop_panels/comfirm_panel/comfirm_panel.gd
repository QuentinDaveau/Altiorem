extends PanelContainer


signal player_answered(answer)



func await_player_answer(cost_to_display: int) -> void:
	$VBoxContainer/RichTextLabel.bbcode_text = "[center]Buy for " + str(cost_to_display) + " [img=50]res://assets/UI/menu_shop.png[/img] ?[/center]"
	mouse_filter = Control.MOUSE_FILTER_STOP



func _reset() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE



func _on_DenyButton_pressed() -> void:
	_reset()
	emit_signal("player_answered", false)



func _on_AcceptButton_pressed() -> void:
	_reset()
	emit_signal("player_answered", true)
