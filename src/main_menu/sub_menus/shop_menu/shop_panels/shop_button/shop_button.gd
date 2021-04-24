extends TextureButton


enum STATE {LOCKED, UNLOCKED, SELECTED}

const LOCKED_TINT: Color = Color(0.5, 0.5, 0.5)

signal buy_requested(cost)

export(String, FILE, "*.tscn") var _target_object = ""
export(int, "background", "shader", "extra") var object_type: int
export(int) var _cost: int = 0

var _current_state: int = STATE.LOCKED



func _ready() -> void:
	_current_state = DataManager.get_data("shop_items_states", {}).get(_target_object, 0)
	
	match _current_state:
		0:
			$LockedSection/PriceLabel.bbcode_text = "[right]" + String(_cost) + " [/right]"
		1:
			$LockedSection.queue_free()
			set_modulate(LOCKED_TINT)
			return
		2:
			$LockedSection.queue_free()
			return



func unlock() -> void:
	_current_state = STATE.SELECTED
	_update_data_manager()
	$AnimationPlayer.play("unlock")
	yield($AnimationPlayer, "animation_finished")
	$LockedSection.queue_free()



func play_deny() -> void:
	$AnimationPlayer.play("deny")



func shake_camera() -> void:
	CameraManager.add_shake(10)



func _select() -> void:
	_current_state = STATE.SELECTED
	_update_data_manager()
	$Tween.interpolate_property(self, "modulate", modulate, Color.white, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	_play_click_animation()
	



func _unselect() -> void:
	_current_state = STATE.UNLOCKED
	_update_data_manager()
	$Tween.interpolate_property(self, "modulate", modulate, LOCKED_TINT, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	_play_click_animation()



func _play_click_animation() -> void:
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	$AnimationPlayer.play("press")



func _update_data_manager() -> void:
	
	var states: Dictionary = DataManager.get_data("shop_items_states", {})
	states[_target_object] = _current_state
	DataManager.add_data("shop_items_states", states)
	
	var data_name := ""
	match object_type:
		0:
			data_name = "activated_backgrounds"
		1:
			data_name = "activated_shaders"
		2:
			data_name = "activated_extras"
	
	var data: Array = DataManager.get_data(data_name, [])
	
	match _current_state:
		1:
			if data.has(_target_object):
				data.erase(_target_object)
		2:
			if not data.has(_target_object):
				data.append(_target_object)
	
	DataManager.add_data(data_name, data)



func _on_ShopButton_pressed() -> void:
	_play_click_animation()
	
	match _current_state:
		STATE.LOCKED:
			emit_signal("buy_requested", _cost)
		STATE.UNLOCKED:
			_select()
		STATE.SELECTED:
			_unselect()
