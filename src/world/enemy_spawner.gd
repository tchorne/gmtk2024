extends Node

@onready var camera: Camera2D = $"../Player/Camera2D"

var wave_size := 5
var enemy_scene = preload("res://src/enemy/enemy.tscn")

var wave_index := 0

const WAVES = [
	# 0 min
	[5, 0, 0, 0, 0, 0],
	[5, 0, 0, 0, 0, 0],
	[10, 0, 0, 0, 0, 0],
	[4, 1, 0, 0, 0, 0],
	[20, 0, 0, 0, 0, 0],
	[15, 5, 0, 0, 0, 0],
	[0, 10, 0, 0, 0, 0],
	[0, 15, 0, 0, 0, 0],
	[0, 10, 2, 0, 0, 0],
	[0, 10, 2, 0, 0, 0],
	# 1 min
]


func get_camera_rect():
	var pos = camera.global_position
	var half_size = camera.get_viewport_rect().size * 0.5 / camera.zoom
	return Rect2(pos-half_size, half_size*2).abs()


func _on_timer_timeout() -> void:
	
	if wave_index >= WAVES.size(): 
		return
	var wave = WAVES[wave_index]
	for i in range(6):
		for count in wave[i]:
			var rect = get_camera_rect()
			var pos := Vector2.ZERO
			var side = randi()%4
			match side:
				0:	# Right
					pos.x = rect.end.x
				1: # Bottom
					pos.y = rect.end.y
				2: # Left
					pos.x = rect.position.x
				3: # Top
					pos.y = rect.position.y
			
			var enemy = enemy_scene.instantiate()
			enemy.boss_tier = i
			get_parent().add_child(enemy)
			enemy.global_position = pos
	wave_index += 1
		
