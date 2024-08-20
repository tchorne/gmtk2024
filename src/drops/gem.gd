extends Area2D

var moving_to_player := false
var t := 0.0
var p1: Vector2
var p2: Vector2

var xp := 10.0


@onready var player : Sprite2D = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	get_tree().root.get_node("Main").reset.connect(func(): queue_free())

func _process(delta: float) -> void:
	rotate(delta*GameSpeed.speed)
	if moving_to_player:
		t += delta * GameSpeed.speed
		var q0 = lerp(p1, p2, t)
		var q1 = lerp(p2, player.global_position, t)
		global_position = lerp(q0, q1, t)
		
func collect():
	queue_free()
	return null
