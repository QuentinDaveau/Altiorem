extends Object

# Class dedicated to interact with the save file to load and save data


func read_file(file_path: String) -> Dictionary:
	var file := File.new()
	var data := {}
	if file.file_exists(file_path):
#		Unencrypted for test
#		file.open_encrypted_with_pass(file_path, File.READ, OS.get_unique_id())
		file.open(file_path, File.READ)
		var v = file.get_var()
		if v is Dictionary: 
			data = v
		else:
			printerr("Unrecognized format, save file may be corrupted")
		file.close()
	return data
	


func write_file(file_path: String, content: Dictionary) -> void:
	var file := File.new()
#	Unencrypted for test
#	file.open_encrypted_with_pass(file_path, File.WRITE, OS.get_unique_id())
	file.open(file_path, File.WRITE)
	file.store_var(content)
