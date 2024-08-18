extends Node

var scales = {}

class ScaleGroup:
	var name : StringName
	var initial_cost := 5
	var cost_increase := 2.0
	func _init(iname, icost, icostincrease):
		name = iname
		initial_cost = icost
		cost_increase = icostincrease
		
func increase_scale(group: StringName):
	if group in scales:
		scales[group] += 1
	else:
		scales[group] = 2

var groups = [
	ScaleGroup.new(&"Bullet", 5, 2.0),
	ScaleGroup.new(&"Enemy", 10, 4.0),
	ScaleGroup.new(&"Player", 10, 4.0),
	ScaleGroup.new(&"Gem", 5, 2.0),
]

var indexed_groups = {}

func _ready():
	for g in groups:
		indexed_groups[g.name] = g
