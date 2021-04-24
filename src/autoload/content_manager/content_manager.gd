extends Node

# Class dedicated to load and store the content selected by the player

var _default_background := "res://content/backgrounds/dawn/Dawn.tscn"
var _default_shader := ""



func get_random_background() -> ParallaxBackground:
	var backgrounds_list: Array = DataManager.get_data("activated_backgrounds", [])
	
	if backgrounds_list.size() == 0:
		return load(_default_background).instance()
	else:
		return load(_pick_random_element(backgrounds_list)).instance()



func get_random_shader() -> ShaderMaterial:
	var shaders_list: Array = DataManager.get_data("activated_shaders", [])
	
	if shaders_list.size() == 0:
		return load(_default_shader).instance()
	else:
		return load(_pick_random_element(shaders_list)).instance()



func _pick_random_element(from_list: Array):
	return from_list[randi() % from_list.size()]
