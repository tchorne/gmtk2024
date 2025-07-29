extends Control


var tween : Tween
@onready var bar: TextureProgressBar = $Bar

func _ready():
	ScaleManager.scales[&"Health"] = 5
	get_tree().root.get_node("Main").reset.connect(func():
		ScaleManager.scales[&"Health"] = 5
		ScaleManager.heals = 0
		)
	get_tree().get_first_node_in_group("Player").hurt.connect(update)
	update()
	
func _on_scale_component_scaled() -> void:
	ScaleManager.scales[&"Health"] += 1
	ScaleManager.heals += 1
	
	update()

func update():
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(bar, "value", ScaleManager.scales[&"Health"]/5.0, 0.2)
	
