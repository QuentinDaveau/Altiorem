extends Node

onready var _main_position = $Camera2D.position


func _ready() -> void:
	$AnimationPlayer.play("menu_appear")
	for m in $SubMenus.get_children():
		m.connect("back_pressed", self, "_on_SubMenu_back_pressed")


func _go_back_to_main() -> void:
	_tween_camera(_main_position)
	yield($CameraTween, "tween_all_completed")
	_clear_menus()


func _show_menu(menu_name: String) -> void:
	for m in $SubMenus.get_children():
		if m.get_name() == menu_name: 
			m.activate()
			_tween_camera(m.position + _main_position)
		else: 
			m.deactivate()


func _clear_menus() -> void:
	for m in $SubMenus.get_children():
		m.deactivate()


func _tween_camera(new_position: Vector2) -> void:
	$CameraTween.interpolate_property($Camera2D, "position", $Camera2D.position,\
			new_position, 0.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	$CameraTween.start()


func _on_PlayButton_pressed() -> void:
	SceneManager.load_game()


func _on_OptionsButton_pressed() -> void:
	_show_menu("OptionsMenu")


func _on_ScoreButton_pressed() -> void:
	_show_menu("ScoreMenu")


func _on_ShopButton_pressed() -> void:
	_show_menu("ShopMenu")


func _on_SubMenu_back_pressed() -> void:
	_go_back_to_main()
