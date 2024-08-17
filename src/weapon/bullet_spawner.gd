extends Node2D

var bullet_scene = preload("res://src/weapon/basic/bullet.tscn")
@onready var game: Node2D = $"../.."

func fire(angle : float):
	var b = bullet_scene.instantiate()
	game.add_child(b)
	b.global_position = global_position
	b.rotation = angle
	
