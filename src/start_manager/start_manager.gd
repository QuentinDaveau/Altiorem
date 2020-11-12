extends Node


func _ready() -> void:
	get_tree().paused = true


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		get_tree().paused = false
		$CanvasLayer/StartUI.visible = false
		set_process_input(false)
