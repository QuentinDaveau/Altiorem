extends Control

signal button_added(button)


export(String, DIR) var _folder_to_scan = ""



func _ready() -> void:
	_generate_buttons()



func _generate_buttons() -> void:
	var dir := Directory.new()
	if dir.open(_folder_to_scan) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				var button = load(_folder_to_scan + "/" + file_name).instance()
				$ScrollContainer/VBoxContainer.add_child(button)
				emit_signal("button_added", button)
			file_name = dir.get_next()
