extends Node

signal section_added(section)


const SECTION_HEIGHT: int = 704
const PRESPAWNED_SECTIONS: int = 2

var _instanciated_sections: Array = []
var _current_step: int = 0


func _ready() -> void:
	CameraManager.observe_camera_position(self, "_on_camera_went_up")
	if not $SectionsLoader.is_ready():
		yield($SectionsLoader, "loading_done")
	for _i in range(PRESPAWNED_SECTIONS):
		_instance_new_section()


func _on_camera_went_up(new_height) -> void:
	if - new_height >= SECTION_HEIGHT * (_current_step - PRESPAWNED_SECTIONS):
		_instance_new_section()


func _instance_new_section() -> void:
	_current_step += 1
	var new_section: Node2D = $SectionsLoader.generate_random_section()
	new_section.global_position = Vector2(0, - SECTION_HEIGHT * _current_step)
	$Sections.add_child(new_section)
	
	if _instanciated_sections.size() > PRESPAWNED_SECTIONS + 2:
		_instanciated_sections[0].queue_free()
		_instanciated_sections.pop_front()
	_instanciated_sections.append(new_section)
	emit_signal("section_added", new_section)



