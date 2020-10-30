extends Node

export(NodePath) var _default_mode_path: NodePath = "Normal"

onready var _default_mode: Node2D = get_node(_default_mode_path)

var _powers := {}
var _powers_stack := []


func _ready() -> void:
	for c in get_children():
		_powers[c.get_name()] = c
		c.connect("deactivated", self, "_on_power_deactivated")


func activate(powerup_name: String) -> void:
	if _powers.has(powerup_name):
		var power = _powers[powerup_name]
		power.activate()
		if not _powers_stack.has(power):
			_powers_stack.append(power)


func process_state(state: Physics2DDirectBodyState) -> Physics2DDirectBodyState:
	if _powers_stack.size() == 0:
		return _default_mode.process_state(state)
	for power in _powers_stack:
		state = power.process_state(state)
	return state


func _on_power_deactivated(power) -> void:
	_powers_stack.erase(power)
