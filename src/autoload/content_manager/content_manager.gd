extends Node

# Class dedicated to load and store the content selected by the player

var _default_background := "res://content/backgrounds/dawn/Dawn.tscn"
var _default_shader := ""


func _enter_tree() -> void:
	randomize()


func get_random_background() -> ParallaxBackground:
	var backgrounds_list: Array = DataManager.get_data("activated_backgrounds", []).duplicate()
	backgrounds_list.append(_default_background)
	return load(_pick_random_element(backgrounds_list)).instance()



func get_random_shader() -> ShaderMaterial:
	var shaders_list: Array = DataManager.get_data("activated_shaders", [])
	shaders_list.append(_default_shader)
	return load(_pick_random_element(shaders_list)).instance()



func _pick_random_element(from_list: Array):
	return from_list[randi() % from_list.size()]
