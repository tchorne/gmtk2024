extends Area2D

var moving_to_player := false
var t := 0.0
var p1: Vector2
var p2: Vector2

var xp := 1.0


@onready var player : Sprite2D = get_tree().get_first_node_in_group("Player")


func _process(delta: float) -> void:
	if moving_to_player:
		t += delta
		var q0 = lerp(p1, p2, t)
		var q1 = lerp(p2, player.global_position, t)
		global_position = lerp(q0, q1, t)
		
func collect():
	queue_free()
	return null
