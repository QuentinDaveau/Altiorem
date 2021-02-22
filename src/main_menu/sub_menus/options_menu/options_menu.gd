extends "../sub_menu.gd"



func _ready() -> void:
	AudioServer.set_bus_mute(1, DataManager.get_data("option_music", false))
	AudioServer.set_bus_mute(2, DataManager.get_data("option_sound", false))
	DarkMode.set_enabled(DataManager.get_data("option_dark", false))


func activate() -> void:
	$MusicPosition/Mover/MusicButton.pressed = AudioServer.is_bus_mute(1)
	$SoundPosition/Mover/SoundButton.pressed = AudioServer.is_bus_mute(2)
	$LightModePosition/Mover/LightModeButton.pressed = DarkMode.is_enabled()
	.activate()


func _on_MusicButton_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(1, button_pressed)
	DataManager.add_data("option_music", button_pressed)


func _on_SoundButton_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(2, button_pressed)
	DataManager.add_data("option_sound", button_pressed)


func _on_LightModeButton_toggled(button_pressed: bool) -> void:
	DarkMode.set_enabled(button_pressed)
	DataManager.add_data("option_dark", button_pressed)


func _on_CreditsButton_pressed() -> void:
	pass
