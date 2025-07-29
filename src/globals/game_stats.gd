extends Node

var kills := 0
var xp := 0
var revives := 0
var scales := 0
var time := 0.0

func _process(delta: float) -> void:
	time += GameSpeed.speed * delta
