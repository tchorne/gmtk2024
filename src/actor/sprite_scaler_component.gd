class_name SpriteScalerComponent
extends Node

@export var scale_amount = 0.3
@export var scale_rate := 1.0
@export var component : ScaleComponent

var animating := false

var base_scale := Vector2.ONE
var initial_scale := Vector2.ONE
var new_scale := Vector2.ONE
var t := 0.0

func _ready():
	if not component and get_parent().has_node("ScaleComponent"):
		component = get_node("../ScaleComponent")
	if component:
		component.scaled.connect(scale)
		base_scale = get_parent().scale
		quick_scale()


func scale():
	initial_scale = get_parent().scale
	new_scale = base_scale * (1 + (scale_amount * (component.get_scale()-1)))
	animating = true
	t = 0.0


func _process(delta: float) -> void:
	if animating:
		t += delta * 1.5 * scale_rate
		if t >= 1.0:
			t = 1.0
			animating = false
		get_parent().scale = lerp(initial_scale, new_scale, smoothstep(0,1,t))
		
## Scales up without animation, used on ready function of parent
func quick_scale():
	get_parent().scale = base_scale * (1 + (scale_amount * (component.get_scale()-1)))
	
