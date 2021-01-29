extends Node2D

signal activated()

export(String) var _power_identifier
export(String, "Ball", "Game", "Score") var _target


func _ready() -> void:
	$Tween.interpolate_property($Sprite, "scale", Vector2.ZERO, $Sprite.scale, 0.3, \
			Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Area2D.set_deferred("monitoring", true)
	$LifeParticle.emitting = true


func get_target() -> String:
	return _target


func get_power_identifier() -> String:
	return _power_identifier


# Activated when the powerup lifetime times out
func _disappear() -> void:
	$Area2D.set_deferred("monitoring", false)
	$LifeParticle.emitting = false
	$Tween.interpolate_property($Sprite, "scale", $Sprite.scale, Vector2.ZERO, 0.2, \
			Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()
	$Timer.start(1.5)
	yield($Timer, "timeout")
	queue_free()


# Activated when the ball touches the powerup icon, "explosion" effect
func _explode() -> void:
	$Area2D.set_deferred("monitoring", false)
	$LifeParticle.emitting = false
	$ExplodeParticle.emitting = true
	$Tween.interpolate_property($Sprite, "scale", $Sprite.scale, $Sprite.scale * 1.5, 0.2,\
			Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Sprite, "self_modulate", $Sprite.self_modulate,\
			Color.transparent, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	$Timer.start(1.5)
	yield($Timer, "timeout")
	queue_free()



func _on_Area2D_body_entered(_body: Node) -> void:
	emit_signal("activated")
	_explode()


func _on_Timer_timeout() -> void:
	_disappear()

