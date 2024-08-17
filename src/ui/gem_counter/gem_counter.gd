extends Node

signal update_xp(xp: float, max: float)
@onready var sound_gem: AudioStreamPlayer = $SoundGem

var current_xp := 0.0
var max_xp := 0.0

func add_xp(xp):
	current_xp = max(current_xp+xp, max_xp)
	sound_gem.play()
	
