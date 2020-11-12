extends Node


func add_target(obstacle: PhysicsBody2D) -> void:
	$PowerUpsSpawner.add_obstacle(obstacle)


func _on_PowerUpsSpawner_spawned_power_up(power_up) -> void:
	call_deferred("add_child", power_up)


func _on_SectionManager_section_added(section) -> void:
	$PowerUpsSpawner.add_blocks_in_section(section)
