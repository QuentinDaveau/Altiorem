extends ColorRect


func set_gradient(top_color: Color, bottom_color: Color) -> void:
	get_material().set_shader_param("TopColor", top_color)
	get_material().set_shader_param("BottomColor", bottom_color)
