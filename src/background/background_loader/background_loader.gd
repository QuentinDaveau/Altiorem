extends Node2D


export(bool) var _unload_panels: bool = true

var _background: ParallaxBackground = null


func _enter_tree() -> void:
	_background = ContentManager.get_random_background()
	_background.set_panels_unload(_unload_panels)
	add_child(_background)



func get_background() -> ParallaxBackground:
	return _background
