extends Node2D


func get_blocks() -> Array:
	var blocks := []
	for b in $Blocks.get_children():
		blocks.append(b)
	return blocks
