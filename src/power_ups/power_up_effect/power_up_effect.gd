extends Node2D

signal deactivated()

export(String) var _identifier

var _activated: bool = false


func get_identifier() -> String:
	return _identifier


func is_activated() -> bool:
	return _activated


func force_deactivation() -> void:
	_deactivate(true)


func activate() -> void:
	if _activated:
		_on_refresh()
		return
	_activated = true
	_on_activation()


func _on_activation() -> void:
	pass


func _on_refresh() -> void:
	pass


func _on_deactivation() -> void:
	pass


func _deactivate(forced: bool = false) -> void:
	_activated = false
	emit_signal("deactivated")
	_on_deactivation()
