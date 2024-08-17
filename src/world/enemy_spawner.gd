extends Node

@onready var camera: Camera2D = $"../Camera2D"

var wave_size := 5
var enemy_scene = preload("res://src/enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_camera_rect():
	var pos = camera.global_position
	var half_size = camera.get_viewport_rect().size * 0.5 / camera.zoom
	return Rect2(pos-half_size, pos+half_size*2)


func _on_timer_timeout() -> void:
	for i in range(wave_size):
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
		get_parent().add_child(enemy)
		enemy.global_position = pos
		
