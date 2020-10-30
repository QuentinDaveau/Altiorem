extends Node

onready var _ball = get_tree().get_nodes_in_group("ball")[0]


func _on_PowerUpsSpawner_spawned_power_up(power_up) -> void:
	power_up.connect("activated", self, "_on_PowerUp_activated",\
			[power_up.get_name(), power_up.is_global()], CONNECT_ONESHOT)


func _on_PowerUp_activated(power_name, is_global) -> void:
	if not is_global:
		_ball.activate_power(power_name)
