extends Node2D

export(String, "Ball", "Game", "Score") var _identifier

var _powerups := {}
var _activated_powerups := []


func _ready() -> void:
	for p in $PowerUps.get_children():
		_powerups[p.get_identifier()] = p
		p.connect("deactivated", self, "_on_powerup_deactivated", [p])


func _on_power_up_spawned(powerup: Node2D) -> void:
	if not powerup.get_target() == _identifier:
		return
	powerup.connect("activated", self, "_on_power_up_activated", [powerup.get_power_identifier()], CONNECT_ONESHOT)


func _on_power_up_activated(powerup_identifier: String) -> void:
	if not _powerups.has(powerup_identifier):
		return
	if not _activated_powerups.has(_powerups[powerup_identifier]):
		_activated_powerups.append(_powerups[powerup_identifier])
	_powerups[powerup_identifier].activate()


func _on_powerup_deactivated(powerup: Node2D) -> void:
	_activated_powerups.erase(powerup)
