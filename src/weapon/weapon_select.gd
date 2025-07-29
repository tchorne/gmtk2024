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
	popup(2)
	get_tree().root.get_node("Main").reset.connect(popup.bind(2))
	
func panel_selected(panel):
	$blip_2.play()
	weapon_selected.emit(panel.data.scene)
	for c in hbox.get_children():
		c.queue_free()
	toggle()

func popup(count: int):
	$blip_1.play()
	
	if not visible:
		for i in count:
			var panel = WEAPON_PANEL.instantiate()
			hbox.add_child(panel)
			panel.set_weapon(i)
			panel.selected.connect(panel_selected.bind(panel))
		toggle()
