extends Node

signal loading_done()

const SECTIONS_FOLDER: String = "res://src/section_manager/section/sections/"

var _loaded_sections: Array = []
var _last_loaded_section: int = -1
var _sections_loaded: bool = false


func _ready() -> void:
	_preload_sections()
	randomize()


func is_ready() -> bool:
	return _sections_loaded


func generate_random_section() -> Node2D:
	var section_index := _get_random_index()
	while section_index == _last_loaded_section:
		section_index = _get_random_index()
	_last_loaded_section = section_index
	return _loaded_sections[section_index].instance()


func _get_random_index() -> int:
	return randi() % _loaded_sections.size()


func _preload_sections() -> void:
	# Preload all sections files contained in sections folder
	var dir := Directory.new()
	if dir.open(SECTIONS_FOLDER) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				_loaded_sections.append(load(SECTIONS_FOLDER + "/" + file_name))
			file_name = dir.get_next()
	_sections_loaded = true
	emit_signal("loading_done")
