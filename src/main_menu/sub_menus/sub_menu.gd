extends Position2D

signal back_pressed()


var _activated: bool = true


func _ready() -> void:
	deactivate()


func activate() -> void:
	if _activated:
		return
	_activated = true
	show()


func deactivate() -> void:
	if not _activated:
		return
	_activated = false
	hide()


func _on_BackButton_pressed() -> void:
	emit_signal("back_pressed")
