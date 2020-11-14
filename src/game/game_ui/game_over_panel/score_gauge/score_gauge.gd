extends Control


export(float, 0, 1) var _spawn_rate: float = 0 setget set_spawn_rate
export(float, 0, 1) var _score_rate: float = 0 setget set_score_rate

# test values
var _best: int = 856
var _mean: int = 520
var _score: int = 1520

var _init_done: bool = false


func _ready() -> void:
	_init_done = true


func set_scores(best: int, mean: int, score: int) -> void:
	_best = best
	_mean = mean
	_score = score


func play_score_counting() -> void:
	$AnimationPlayer.play("count_score")


func set_spawn_rate(value: float) -> void:
	_spawn_rate = value
	if not _init_done:
		return
	
	$Best.set_amount(_best * value, _best)
	$Mean.set_amount(_mean * value, _best)


func set_score_rate(value: float) -> void:
	_score_rate = value
	if not _init_done:
		return
	
	var new_amount = _score * value
	
	if $Score.get_amount() < $Mean.get_amount() && new_amount > $Mean.get_amount():
		$Mean.highlight()
	if $Score.get_amount() < $Best.get_amount() && new_amount > $Best.get_amount():
		$Best.highlight()
	
	if new_amount > $Best.get_amount():
		$Best.set_amount(_best * float(_best) / (_score * value), _best)
		$Mean.set_amount(_best * float(_mean) / (_score * value), _best)
	
	$Score.set_amount(new_amount, _best)
