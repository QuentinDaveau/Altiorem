extends Node

signal spawned_power_up(power_up)


func add_blocks_in_section(section: Node2D) -> void:
	for b in section.get_obstacles():
		b.connect("destroyed", self, "_on_block_destroyed", [section])


func _on_block_destroyed(proc_coeff: float, position: Vector2, section: Node2D) -> void:
	if _passes_proc_chance(proc_coeff):
		_add_power_up(position)


func _passes_proc_chance(proc_coeff: float) -> bool:
	return randf() < proc_coeff


func _add_power_up(position: Vector2) -> void:
	var power = $PowerUpsLoader.generate_random_power()
	power.position = position
	emit_signal("spawned_power_up", power)
