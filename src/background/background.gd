extends ParallaxBackground


func set_panels_unload(value: bool) -> void:
	$FarLayer/PanelManager.unload_panels = value



func get_gradient() -> Gradient:
	return $FarLayer/PanelManager.get_gradient()
