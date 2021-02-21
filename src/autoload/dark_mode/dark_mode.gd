extends CanvasLayer


func set_enabled(enable: bool) -> void:
	$ColorRect.get_material().set_shader_param("enabled", enable)


func is_enabled() -> bool:
	return $ColorRect.get_material().get_shader_param("enabled")
