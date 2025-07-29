extends Node

@onready var camera = get_tree().get_first_node_in_group("GameCamera")

var p0
var p1
var t := 0.0
var animating := false

func begin_scale(original_zoom, new_zoom):
	p0 = original_zoom
	p1 = new_zoom
	animating = true
	t = 0.0

func _process(delta):
	if animating:
		t += delta
		if t >= 1.0:
			animating = false
			t = 1.0
		camera.zoom = lerp(p0, p1, smoothstep(0, 1, t))
		
