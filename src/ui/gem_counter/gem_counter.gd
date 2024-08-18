extends Node

signal update_xp(xp: float, max: float)
@onready var sound_gem: AudioStreamPlayer = $SoundGem
@onready var xp_bar = get_tree().get_first_node_in_group("XPBar")


var current_xp := 0.0
var max_xp := 50.0

func add_xp(xp):
	current_xp = min(current_xp+xp, max_xp)
	sound_gem.play()
	xp_bar.update(current_xp, max_xp)
	
func scale(level):
	max_xp = 50.0 * (1.2**(level-1))
