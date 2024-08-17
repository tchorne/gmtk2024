class_name Weapon
extends Sprite2D

@export_node_path("Sprite2D") var player_path

@onready var player : Sprite2D = get_node(player_path)
@onready var sound_fire: AudioStreamPlayer = $SoundFire
@onready var enemy_detector: Area2D = $EnemyDetector


var weapon_distance := 225.0

var mouse_pos : Vector2
var camera_zoom = 0.25
var cursor_position: Vector2
var alpha : float

var fire_rate := 1.0/3.0
var fire_charge := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = player.get_global_mouse_position()
		

func _process(delta):
	alpha += delta * GameSpeed.speed
	update_facing()
	process_fire(delta)
	
func process_fire(delta):

	#if InputHandler.input_owner != InputHandler.GAME:
	#	return
		
	fire_charge += delta * GameSpeed.speed
	while fire_charge > fire_rate:
		fire_charge -= fire_rate
		fire()
		
		
func fire():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies.size() <= 0: return
	
	sound_fire.play()
	
	var closest_enemy = enemies[0]
	var closest_distance = global_position.distance_to(enemies[0].global_position)
	for e in enemies:
		var d = global_position.distance_to(e.global_position)
		if d < closest_distance:
			closest_enemy = e
			closest_distance = d
	
	look_at(closest_enemy.global_position)	
	
	for c in get_children():
		var facing = get_facing()
		if c.has_method('fire'):
			c.fire(facing)
	
		
	
	
		
func update_facing():
	var player_to_cursor = cursor_position-player.global_position
	position = player.global_position + Vector2.RIGHT.rotated(alpha) * weapon_distance
	rotation = player_to_cursor.angle()

func get_facing() -> float:
	return rotation
