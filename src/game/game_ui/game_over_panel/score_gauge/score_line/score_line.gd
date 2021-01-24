extends Line2D

const MAX_HEIGHT: int = 500


export(String) var _top_text: String = ""
export(bool) var _is_left: bool = true

var _amount: float = 0
var _text_label: RichTextLabel


func _ready() -> void:
	_text_label = $Control/HBoxContainer/RichTextLabel
	_update_text()


func highlight() -> void:
	$AnimationPlayer.play("highlight")


func disappear() -> void:
	$AnimationPlayer.play("disappear")


func set_amount(amount: float, max_value: int) -> void:
	_amount = amount
	var p = MAX_HEIGHT * min(amount, max_value) / max_value if max_value > 0 else MAX_HEIGHT * min(amount, 1)
	points[1] = Vector2.UP * p
	$Control.rect_position.y = - p
	_update_text()


func set_top_text(text: String) -> void:
	_top_text = text
	_update_text()


func get_amount() -> float:
	return _amount


func _update_text() -> void:
	var text_content: String
	
	if _top_text:
		text_content = _top_text
	else:
		text_content = String(int(_amount))
	
	if _is_left:
		_text_label.bbcode_text = "[right]" + text_content + " [/right]"
	else:
		_text_label.bbcode_text = " " + text_content

