extends Node

var scales = {}
var heals = 0

class ScaleGroup:
	var name : StringName
	var desc : String
	var initial_cost := 5
	var cost_increase := 2.0
	var max_level := 9999
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
	ScaleGroup.new(&"Health", "Health ↑", 10, 1.5),
	ScaleGroup.new(&"Bullet", "Damage ↑", 5, 2.0),
	ScaleGroup.new(&"Enemy", "Health ↑ Gems ↑", 10, 4.0),
	ScaleGroup.new(&"Player", "Speed ↑ Scale ↑",10, 4.0),
	ScaleGroup.new(&"Gem", "Value ↑", 5, 2.0),
	ScaleGroup.new(&"Cannon", "Fire Rate ↑", 8, 4.0),
	ScaleGroup.new(&"Slash", "Fire Rate ↑", 5, 2.0),
	ScaleGroup.new(&"Slicer", "Slices ↑ Speed ↑", 5, 2.0),
	
	ScaleGroup.new(&"CannonSplash", "Splash Damage Radius ↑", 10, 2.0),
	ScaleGroup.new(&"XPBar", "Gem Capacity ↑", 10, 2.5),
	ScaleGroup.new(&"WeaponStar", "Options ↑", 2, 5),
]

var indexed_groups = {}

func _ready():
	for g in groups:
		indexed_groups[g.name] = g
	get_tree().root.get_node("Main").reset.connect(func():
		scales[&"Enemy"] = 1
		scales[&"Health"] = 5
		)
	indexed_groups[&"Health"].max_level = 5

func get_cost(group):
	if group == &"": return 0
	var cost = indexed_groups[group].initial_cost * (indexed_groups[group].cost_increase ** (scales.get(group,1)-1))
	if group == &"Health":
		cost *= 1.5 ** heals
	return cost
	
