extends TextureProgressBar

@onready var subtract_bar: TextureProgressBar = $SubtractBar

var t := 0.0
var max: float
var x_scale := 229.0 : set=set_x_scale

func set_x_scale(new):
	x_scale = new
	print(x_scale)
	size.x = x_scale
	if subtract_bar:
		subtract_bar.size.x = x_scale

var tween: Tween
func update(xp: float, new_max: float):
	max = new_max
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "value", xp / max, 0.3)

func update_cost(xp):
	subtract_bar.value = xp / max
	var length = size.x * subtract_bar.value
	subtract_bar.position.x = lerp(0.0, size.x, value) - length
	subtract_bar.self_modulate = Color.RED if subtract_bar.value > value else Color.CORAL
	
	
func _process(delta):
	t += delta
	subtract_bar.self_modulate.a = abs(sin(t * 4.0))
	
	subtract_bar.position.x = lerp(0.0, size.x, value) - size.x * subtract_bar.value
	
func _on_scale_component_scaled() -> void:
	get_tree().get_first_node_in_group("GemCounter").scale($Center/ScaleComponent.get_scale())
