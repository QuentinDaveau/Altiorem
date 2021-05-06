extends Control

signal coin_amount_updated()


onready var _scroll_container = $PanelContainer/VBoxContainer/ScrollContainer



func _process_player_request(source_button, cost: int) -> void:
	if not _check_wallet(cost):
		source_button.play_deny()
		return
	
	$PanelContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$AnimationPlayer.play("confirm_panel_enter")
	$ComfirmPanel.await_player_answer(cost)
	
	_process_player_answer(yield($ComfirmPanel, "player_answered"), cost, source_button)
	
	$AnimationPlayer.play("comfirm_panel_exit")
	yield($AnimationPlayer, "animation_finished")
	$PanelContainer.mouse_filter = Control.MOUSE_FILTER_STOP



func _check_wallet(cost: int) -> bool:
	return DataManager.get_data("points", 0) >= cost



func _process_player_answer(answer: bool, cost: int, button) -> void:
	if answer:
		DataManager.add_data("points", DataManager.get_data("points", 0) - cost)
		emit_signal("coin_amount_updated")
		button.unlock()



func _on_SkinsButton_pressed() -> void:
	_tween_scroll(0)



func _on_BackgroundsButton_pressed() -> void:
	_tween_scroll(1)



func _on_ExtrasButton_pressed() -> void:
	_tween_scroll(2)



func _tween_scroll(index: int) -> void:
	$Tween.interpolate_property(_scroll_container, "scroll_horizontal", \
			_scroll_container.scroll_horizontal, _scroll_container.rect_size.x * index, \
			0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()



func _on_ShopPanel_button_added(button) -> void:
	button.connect("buy_requested", self, "_on_button_buy_requested", [button])



func _on_button_buy_requested(cost: int, button) -> void:
	_process_player_request(button, cost)

