extends Node

@onready var camera: Camera2D = $"../Player/Camera2D"

const WAVE_TIME = 7.0

var time_to_next_wave := 0.0

var wave_size := 5
var enemy_scene = preload("res://src/enemy/enemy.tscn")

var wave_index := 0

const WAVES = [
	# 0 min
	[3, 0, 0, 0, 0, 0],
	[6, 1, 0, 0, 0, 0],
	[5, 0, 0, 0, 0, 0],
	[15, 2, 1, 0, 0, 0],
	[20, 5, 0, 0, 0, 0],
	[0, 8, 2, 0, 0, 0],
	# 1 min
	[0, 15, 0, 0, 0, 0],
	[0, 15, 5, 0, 0, 0],
	[0, 0, 8, 1, 0, 0],
	[0, 0, 4, 0, 0, 0],
	[0, 0, 16, 2, 0, 0],
	[0, 0, 0, 2, 0, 0],
	# 2 min
	[0, 0, 0, 6, 0, 0],
	[0, 0, 25, 0, 1, 0],
	[100, 0, 8, 1, 0, 0],
	[0, 0, 0, 2, 0, 0],
	[0, 0, 16, 2, 2, 0],
	[0, 0, 0, 2, 0, 0],
	# 3 min
	[0, 0, 0, 0, 0, 1],
	[0, 0, 0, 0, 8, 0],
	[0, 0, 50, 0, 0, 0],
	[0, 0, 0, 0, 0, 2],
	[0, 0, 0, 0, 12, 0],
	[0, 0, 30, 20, 0, 0],
	[0, 0, 0, 0, 15, 5],
	[0, 0, 0, 0, 0, 0],
	
]


func _ready():
	get_tree().root.get_node("Main").reset.connect(reset)

func _process(delta: float) -> void:
	time_to_next_wave -= delta * GameSpeed.speed
	if time_to_next_wave < 0.0:
		time_to_next_wave = WAVE_TIME
		_on_timer_timeout()

func reset():
	wave_index = 0
	time_to_next_wave = 0.0
	
func get_camera_rect():
	var pos = camera.global_position
	var half_size = camera.get_viewport_rect().size * 0.5 / camera.zoom
	half_size *= 1.2
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
			if side == 0 or side == 2: # Left, right
				pos.y = randf_range(rect.position.y, rect.end.y)
			else:
				pos.x = randf_range(rect.position.x, rect.end.x)
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
		
