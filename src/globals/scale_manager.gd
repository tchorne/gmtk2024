extends Node

var scales = {}

class ScaleGroup:
	var name : StringName
	var desc : String
	var initial_cost := 5
	var cost_increase := 2.0
	func _init(iname, idesc, icost, icostincrease):
		name = iname
		desc = idesc
		initial_cost = icost
		cost_increase = icostincrease
		
func increase_scale(group: StringName):
	if group in scales:
		scales[group] += 1
	else:
		scales[group] = 2

var groups = [
	ScaleGroup.new(&"Bullet", "Damage ↑", 5, 2.0),
	ScaleGroup.new(&"Enemy", "Health ↑ Gems ↑", 10, 4.0),
	ScaleGroup.new(&"Player", "Speed ↑ Scale ↑",10, 4.0),
	ScaleGroup.new(&"Gem", "Value ↑", 5, 2.0),
	ScaleGroup.new(&"Weapon", "Fire Rate ↑", 5, 2.0),
	ScaleGroup.new(&"CannonSplash", "Splash Damage Radius ↑", 10, 2.0),
	ScaleGroup.new(&"XPBar", "Gem Capacity ↑", 10, 1.5),
	
]

var indexed_groups = {}

func _ready():
	for g in groups:
		indexed_groups[g.name] = g

func get_cost(group):
	if group == &"": return 0
	return indexed_groups[group].initial_cost * (indexed_groups[group].cost_increase ** (scales.get(group,1)-1))
	
