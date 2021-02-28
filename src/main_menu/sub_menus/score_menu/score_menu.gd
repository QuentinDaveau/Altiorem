extends "../sub_menu.gd"


const INTERPOLATE_DURATION: float = 1.0

onready var _best = $BestNPosition/Mover/BestNLabel
onready var _mean = $MeanNPosition/Mover/MeanNLabel
onready var _games = $PlayedGamesNPosition/Mover/PlayedGamesNLabel
onready var _max_height = $MaxHeightPosition2/Mover/MaxHeightNLabel
onready var _max_breaks = $MaxBlockBreakNPosition/Mover/MaxBlockNLabel


func activate() -> void:
	.activate()
	if -DataManager.get_data("max_height", 0) * 10 < global_position.y:
		global_position.y = -DataManager.get_data("max_height", 0) * 10
	_reset_texts()
	$Tween.interpolate_method(self, "_interpolate_scores", 0.0, 2.0, INTERPOLATE_DURATION, \
			Tween.TRANS_QUINT, Tween.EASE_OUT, 0.4)
	$Tween.start()


func _interpolate_scores(interpolate_amount: float) -> void:
	_set_target_text(_best, int(DataManager.get_data("best", 0) * interpolate_amount))
	_set_target_text(_mean, int(DataManager.get_data("mean", 0) * interpolate_amount))
	_set_target_text(_games, int(DataManager.get_data("games", 0) * interpolate_amount))
	_set_target_text(_max_height, int(DataManager.get_data("max_height", 0) * interpolate_amount))
	_set_target_text(_max_breaks, int(DataManager.get_data("max_breaks", 0) * interpolate_amount))


func _reset_texts() -> void:
	_set_target_text(_best, 0)
	_set_target_text(_mean, 0)
	_set_target_text(_games, 0)
	_set_target_text(_max_height, 0)
	_set_target_text(_max_breaks, 0)


func _set_target_text(target: RichTextLabel, value: int) -> void:
	target.bbcode_text = "[center][rainbow freq=0.3 sat=0.1 val=1]" + String(value) + "[/rainbow][/center]"
