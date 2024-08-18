extends Area2D

var moving_to_player := false
var t := 0.0
var p1: Vector2
var p2: Vector2
var xp := 0

@onready var player : Sprite2D = get_tree().get_first_node_in_group("Player")

var bonus_options := 1
func _ready():
	var vec = player.global_position - global_position
	
	p1 = global_position
	p2 = global_position + vec.rotated(PI/2) * randf() * 0.2 + randf()*vec
	
func _process(delta: float) -> void:
	moving_to_player = true
	
	rotate(delta*GameSpeed.speed*3.0)
	if moving_to_player:
		t += delta * GameSpeed.speed / 2.0
		var q0 = lerp(p1, p2, t)
		var q1 = lerp(p2, player.global_position, t)
		global_position = lerp(q0, q1, t)
		
func collect():
	get_tree().get_first_node_in_group("WeaponSelect").popup(2+bonus_options)
	
	queue_free()
	return null
