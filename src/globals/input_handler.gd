extends Node

const SCALE_SELECT = 0
const GAME = 1

var scale_select := false
var game := true

var input_owner : int = GAME

func _process(_delta: float) -> void:
	if scale_select:
		input_owner = SCALE_SELECT
		return
	
	if game:
		input_owner = GAME
		return
		
