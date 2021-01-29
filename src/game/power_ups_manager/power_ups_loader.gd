extends Node

signal loading_done()

const POWERS_FOLDER: String = "res://src/power_ups/power_up_pickable/pickables/"

var _loaded_powers: Array = []


func _ready() -> void:
	_preload_powers()
	randomize()


func generate_random_power() -> Node2D:
	return _loaded_powers[_get_random_index()].instance() if _loaded_powers else null


func _get_random_index() -> int:
	return randi() % _loaded_powers.size()


func _preload_powers() -> void:
	# Preload all power up files contained in power_ups folder
	var dir := Directory.new()
	if dir.open(POWERS_FOLDER) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				_loaded_powers.append(load(POWERS_FOLDER + "/" + file_name))
			file_name = dir.get_next()
	emit_signal("loading_done")
