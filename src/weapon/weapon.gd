class_name Weapon
extends Sprite2D

@export_node_path("Sprite2D") var player_path

@onready var player : Sprite2D = get_tree().get_first_node_in_group("Player")
@onready var sound_fire: AudioStreamPlayer = $SoundFire
@onready var enemy_detector: Area2D = $EnemyDetector

var mouse_pos : Vector2
var camera_zoom = 0.25
var cursor_position: Vector2


var fire_rate := 1.0/3.0
var fire_charge := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = player.get_global_mouse_position()
		

func _process(delta):
	
	process_fire(delta)
	process_movement(delta)
	
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

func process_movement(_delta):
	return

func get_facing() -> float:
	return rotation
