extends Node

var scales = {}

class ScaleGroup:
	var name : StringName
	var initial_cost := 5
	var cost_increase := 2.0

func increase_scale(group: StringName):
	if group in scales:
		scales[group] += 1
	else:
		scales[group] = 2
