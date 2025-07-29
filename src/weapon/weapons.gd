extends Node2D

func _ready():
	get_tree().get_first_node_in_group("WeaponSelect").weapon_selected.connect(_on_weapon_selected)
	get_tree().root.get_node("Main").reset.connect(func():
		for c in get_children():
			c.queue_free()
		
		)
func _on_weapon_selected(scene : PackedScene):
	add_child(scene.instantiate())
