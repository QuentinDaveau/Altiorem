extends TextureButton

export(bool) var _disable_animation: bool = false


func _ready() -> void:
	rect_pivot_offset = rect_size / 2


func _on_ButtonEffect_pressed() -> void:
	if not _disable_animation:
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.stop()
		$AnimationPlayer.play("press")
