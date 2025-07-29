extends Panel

signal selected

class WeaponData:
	var desc : String
	var name : String
	var texture : Texture
	var scene : PackedScene
	var color : Color
	func _init(iname, idesc, img_path, scene_path, icolor=Color.WHITE) -> void:
		desc = idesc
		name = iname
		texture = ImageTexture.create_from_image(Image.load_from_file(img_path))
		scene = load(scene_path)
		color = icolor
		

static var WEAPONS = [
	WeaponData.new("Cannon", "Fires towards the nearest enemy", "res://assets/open/triangle.png", "res://src/weapon/basic/cannon.tscn", Color(0.49, 1, 1)),
	WeaponData.new("Slash", "Pierces through enemies", "res://assets/open/triangle.png", "res://src/weapon/slash/slash.tscn", Color(0.49, 1, 0.608)),
	WeaponData.new("Launcher", "Creates a devastating explosion", "res://assets/open/triangle.png", "res://src/weapon/basic/launcher.tscn", Color(1, 0.329, 0.329))
	
	
]

var data: WeaponData

func _ready():
	pass

func set_weapon(index):
	data = WEAPONS[index%3]
	$VBoxContainer/Label.text = data.name
	$VBoxContainer/Label2.text = data.desc
	#$VBoxContainer/Control/TextureRect.texture = data.texture
	$VBoxContainer.modulate = data.color

func _on_texture_button_pressed() -> void:
	selected.emit()
