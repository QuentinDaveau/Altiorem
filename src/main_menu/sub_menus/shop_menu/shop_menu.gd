extends "../sub_menu.gd"


func activate() -> void:
	.activate()
	_set_points_amount(DataManager.get_data("points", 0))



func _set_points_amount(amount: int) -> void:
	$CoinsAmount.bbcode_text = "[right]" + String(amount) + " [/right]"



func _on_ShopCanvas_coin_amount_updated() -> void:
	_set_points_amount(DataManager.get_data("points", 0))
