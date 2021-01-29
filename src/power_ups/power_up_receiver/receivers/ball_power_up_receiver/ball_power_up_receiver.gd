extends "../../power_up_receiver.gd"


func process_state(state: Physics2DDirectBodyState) -> Physics2DDirectBodyState:
	if not _activated_powerups:
		return $NoPowerState.process_state(state)
	for p in _activated_powerups:
		state = p.process_state(state)
	return state
