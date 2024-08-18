extends Node


var pause_factor := 1.0
var scale_select_factor := 1.0
var weapon_select_factor := 1.0
var hitstun_factor := 1.0


var speed := 1.0

func _process(_delta: float) -> void:
	speed = pause_factor * min(scale_select_factor, weapon_select_factor) * hitstun_factor
	
