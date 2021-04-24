extends HBoxContainer

var _current_enabled: int = 0
var _unselected_color := Color(0.8, 0.8, 0.8)



func _ready() -> void:
	$SkinsButton.rect_scale = Vector2(1.2, 1.2)
	$BackgroundsButton.rect_scale = Vector2(1, 1)
	$ExtrasButton.rect_scale = Vector2(1, 1)
	$BackgroundsButton.self_modulate = _unselected_color
	$ExtrasButton.self_modulate = _unselected_color



func _play_effect(new_enabled: int) -> void:
	if (new_enabled == _current_enabled):
		return
	_prepare_disabling_anim(_get_id_button(_current_enabled))
	_prepare_enabling_anim(_get_id_button(new_enabled))
	$Tween.start()
	_current_enabled = new_enabled



func _prepare_enabling_anim(target: Node) -> void:
	$Tween.interpolate_property(target, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.2, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.interpolate_property(target, "self_modulate", _unselected_color, Color.white, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	target.disabled = true



func _prepare_disabling_anim(target: Node) -> void:
	$Tween.interpolate_property(target, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.2, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.interpolate_property(target, "self_modulate", Color.white, _unselected_color, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	target.disabled = false



func _get_id_button(id: int) -> Node:
	match id:
		0:
			return $SkinsButton
		1:
			return $BackgroundsButton
		2:
			return $ExtrasButton
	return null



func _on_SkinsButton_pressed() -> void:
	_play_effect(0)



func _on_BackgroundsButton_pressed() -> void:
	_play_effect(1)



func _on_ExtrasButton_pressed() -> void:
	_play_effect(2)
