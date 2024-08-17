extends Node

var scales = {}

func increase_scale(group: StringName):
	if group in scales:
		scales[group] += 1
	else:
		scales[group] = 2
