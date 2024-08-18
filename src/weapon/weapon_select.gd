extends Control

signal weapon_selected(scene : PackedScene)
const WEAPON_PANEL = preload("res://src/weapon/weapon_panel.tscn")
@onready var hbox: HBoxContainer = $HBoxContainer

func toggle():
	visible = not visible
	if visible:
		pass
		
func _ready():
	for i in 3:
		var panel = WEAPON_PANEL.instantiate()
		hbox.add_child(panel)
		panel.selected.connect(panel_selected.bind(panel))

func panel_selected(panel):
	
