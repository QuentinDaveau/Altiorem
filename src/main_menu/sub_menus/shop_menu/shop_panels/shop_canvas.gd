extends Control

onready var _scroll_container = $VBoxContainer/ScrollContainer


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
