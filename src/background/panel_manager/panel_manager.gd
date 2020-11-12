tool
extends Node2D

const PANEL_HEIGHT: int = 512
const PRESPAWNED_PANELS: int = 4
const MAX_LENGTH: float = 20.0
const LAYER_SCALE: float = 0.1

export(Gradient) var _gradient: Gradient

onready var _panel = load("res://src/background/panel/Panel.tscn")

var _instanciated_panels: Array = []
var _current_step: int = -1

var _camera_height: float = 512

func _ready() -> void:
	if Engine.editor_hint:
		for _i in range(20):
			_instance_new_panels()
		return
	CameraManager.observe_camera_position(self, "_on_camera_went_up")
	for _i in range(PRESPAWNED_PANELS):
		_instance_new_panels()


func _on_camera_went_up(new_height: float) -> void:
	if - new_height >= PANEL_HEIGHT * (_current_step - PRESPAWNED_PANELS) / LAYER_SCALE:
		_instance_new_panels()


func _instance_new_panels() -> void:
	_current_step += 1
	var new_panel: Sprite = _panel.instance()
	if Engine.editor_hint:
		new_panel.position = Vector2(new_panel.position.x, - PANEL_HEIGHT * _current_step)
		new_panel.get_material().set_shader_param("TopColor", _gradient.interpolate((_current_step - 1) / MAX_LENGTH))
		new_panel.get_material().set_shader_param("BottomColor", _gradient.interpolate(_current_step / MAX_LENGTH))
		$Panels.add_child(new_panel)
		return
	new_panel.set_gradient(_gradient.interpolate((_current_step - 1) / MAX_LENGTH),\
			_gradient.interpolate(_current_step / MAX_LENGTH))
	new_panel.position = Vector2(new_panel.position.x, - PANEL_HEIGHT * _current_step)
	$Panels.add_child(new_panel)
	if _instanciated_panels.size() > PRESPAWNED_PANELS + 4:
		_instanciated_panels[0].queue_free()
		_instanciated_panels.pop_front()
	_instanciated_panels.append(new_panel)
