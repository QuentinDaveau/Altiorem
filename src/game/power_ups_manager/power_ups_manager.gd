extends Node


func add_target(obstacle: PhysicsBody2D) -> void:
	$PowerUpsSpawner.add_obstacle(obstacle)


func _on_power_up_spawned(power_up: Node2D) -> void:
	call_deferred("add_child", power_up)


func _on_SectionManager_section_added(section: Node2D) -> void:
	$PowerUpsSpawner.add_blocks_in_section(section)
