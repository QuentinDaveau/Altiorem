tool
extends Sprite


export(int, -1000, 1000) var _scroll_speed: int


func _process(delta: float) -> void:
	region_rect.position.x += _scroll_speed * delta
