extends Node

const PANEL_HEIGHT: int = 1024
const PRESPAWNED_PANELS: int = 2
const MAX_LENGTH: float = 10.0

export(Gradient) var _gradient: Gradient

onready var _panel = load("res://src/background/panel/Panel.tscn")

var _instanciated_panels: Array = []
var _current_step: int = 0

var _camera_height: float = 512

func _ready() -> void:
	CameraManager.observe_camera_position(self, "_on_camera_went_up")
	for _i in range(PRESPAWNED_PANELS):
		_instance_new_panels()


func _on_camera_went_up(new_height) -> void:
	if - new_height >= PANEL_HEIGHT * (_current_step - PRESPAWNED_PANELS):
		_instance_new_panels()


func _instance_new_panels() -> void:
	_current_step += 1
	var new_panel: ColorRect = _panel.instance()
	new_panel.set_gradient(_gradient.interpolate((_current_step - 1)/MAX_LENGTH), _gradient.interpolate((_current_step)/MAX_LENGTH))
	new_panel.rect_position = Vector2(new_panel.rect_position.x, - PANEL_HEIGHT * _current_step)
	$Panels.add_child(new_panel)
	
	if _instanciated_panels.size() > PRESPAWNED_PANELS + 2:
		_instanciated_panels[0].queue_free()
		_instanciated_panels.pop_front()
	_instanciated_panels.append(new_panel)
