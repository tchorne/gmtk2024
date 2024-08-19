extends Panel

signal selected

class WeaponData:
	var desc : String
	var name : String
	var texture : Texture
	var scene : PackedScene
	func _init(iname, idesc, img_path, scene_path) -> void:
		desc = idesc
		name = iname
		texture = ImageTexture.create_from_image(Image.load_from_file(img_path))
		scene = load(scene_path)

static var WEAPONS = [
	WeaponData.new("Cannon", "Fires towards the nearest enemy", "res://assets/open/triangle.png", "res://src/weapon/basic/cannon.tscn"),
	WeaponData.new("Slash", "Pierces through enemies", "res://assets/open/triangle.png", "res://src/weapon/slash/slash.tscn")
	
	
]

var data: WeaponData

func _ready():
	data = WEAPONS.pick_random()
	$VBoxContainer/Label.text = data.name
	$VBoxContainer/Label2.text = data.desc
	$VBoxContainer/Control/TextureRect.texture = data.texture

func _on_texture_button_pressed() -> void:
	selected.emit()
