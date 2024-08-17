extends Sprite2D

@export_node_path("Sprite2D") var player_path

@onready var player : Sprite2D = get_node(player_path)

var weapon_distance := 225.0

var mouse_pos : Vector2
var camera_zoom = 0.25
var cursor_position: Vector2

var fire_rate := 1.0/5.0
var fire_charge := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = player.get_global_mouse_position()
		

func _process(delta):
	update_facing()
	process_fire(delta)
	
func process_fire(delta):
	if not Input.is_action_pressed('primary'):
		fire_charge = 0.0
		return
	if InputHandler.input_owner != InputHandler.GAME:
		return
		
	fire_charge += delta
	while fire_charge > fire_rate:
		fire_charge -= fire_rate
		fire()
		
func fire():
	for c in get_children():
		var facing = get_facing()
		if c.has_method('fire'):
			c.fire(facing)
	
		
func update_facing():
	var player_to_cursor = cursor_position-player.global_position
	position = player.global_position + player_to_cursor.normalized() * weapon_distance
	rotation = player_to_cursor.angle()

func get_facing() -> float:
	return (cursor_position-player.global_position).angle()
