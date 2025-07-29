extends Control

@onready var scale_select: Node = $"../../../../ScaleSelect"
@onready var gem_counter = get_tree().get_first_node_in_group("GemCounter")

func _process(delta: float) -> void:
	if ScaleManager.scales[&"XPBar"] > 1: queue_free()
	
	visible = scale_select.visible and gem_counter.current_xp >= gem_counter.max_xp
