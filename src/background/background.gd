extends ParallaxBackground


func set_panels_unload(value: bool) -> void:
	$FarLayer/PanelManager.unload_panels = value
