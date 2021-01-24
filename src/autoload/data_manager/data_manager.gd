extends Node

#	Class dedicated to save and load datas of the game such as scores or currency

const SAVE_PATH: String = "user://save.dat"
const PARSER_PATH: String = "res://src/autoload/data_manager/file_parser.gd"

var _parser: Node
var _datas: Dictionary


func _ready() -> void:
	_parser = _instanciate_parser()
	_datas = _parser.read_file(SAVE_PATH)
	print(_datas)


func add_data(data_name: String, value) -> void:
	_datas[data_name] = value
	_parser.write_file(SAVE_PATH, _datas)


func get_data(data_name: String, default = null):
	return _datas.get(data_name, default)


func _instanciate_parser() -> Node:
	var p = preload(PARSER_PATH).new()
	return p
