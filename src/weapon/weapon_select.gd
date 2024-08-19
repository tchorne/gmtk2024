extends Control

signal weapon_selected(scene : PackedScene)
const WEAPON_PANEL = preload("res://src/weapon/weapon_panel.tscn")
@onready var hbox: HBoxContainer = $HBoxContainer

func toggle():
	visible = not visible
	GameSpeed.weapon_select_factor = 0.02 if visible else 1.0
	if visible:
		pass
		
func _ready():
	popup(3)
	
func panel_selected(panel):
	weapon_selected.emit(panel.data.scene)
	for c in hbox.get_children():
		c.queue_free()
	toggle()

func popup(count: int):
	if not visible:
		for i in count:
			var panel = WEAPON_PANEL.instantiate()
			hbox.add_child(panel)
			panel.selected.connect(panel_selected.bind(panel))
		toggle()
