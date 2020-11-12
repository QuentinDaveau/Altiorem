extends Node

signal spawned_power_up(power_up)


func add_obstacle(obstacle: PhysicsBody2D) -> void:
		obstacle.connect("destroyed", self, "_on_obstacle_destroyed",\
		[obstacle.get_proc_chance(), obstacle.global_position])


func _on_obstacle_destroyed(proc_chance: float, position: Vector2) -> void:
	if _passes_proc_chance(proc_chance):
		_add_power_up(position)


func _passes_proc_chance(proc_chance: float) -> bool:
	return randf() < proc_chance


func _add_power_up(position: Vector2) -> void:
	var power = $PowerUpsLoader.generate_random_power()
	power.position = position
	emit_signal("spawned_power_up", power)
