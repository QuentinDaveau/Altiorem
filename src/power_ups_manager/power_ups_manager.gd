extends Node


func _on_SectionManager_section_added(section: Node2D) -> void:
	for b in section.get_blocks():
		b.connect("destroyed", self, "_on_block_destroyed", [section])


func _on_block_destroyed(proc_coeff: float, position: Vector2, section: Node2D) -> void:
	if _pass_proc_chance(proc_coeff):
		_add_power_up(position, section)


func _pass_proc_chance(proc_coeff: float) -> bool:
	return randf() < proc_coeff


func _add_power_up(position: Vector2, parent: Node2D) -> void:
	var power = $PowerUpsLoader.generate_random_power()
	power.position = position
	parent.call_deferred("add_child", power)
