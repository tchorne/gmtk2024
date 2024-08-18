extends Node2D

func _ready():
	get_tree().get_first_node_in_group("WeaponSelect").weapon_selected.connect(_on_weapon_selected)

func _on_weapon_selected(scene : PackedScene):
	add_child(scene.instantiate())
