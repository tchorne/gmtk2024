extends Sprite2D

signal killed

const GEM = preload("res://src/drops/gem.tscn")

var speed := 200.0

var gem_count := 1

var max_health := 10.0
var health := max_health

var player: Sprite2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
func _process(delta: float) -> void:
	var dir = (player.global_position - global_position).normalized()
	
	translate(dir*delta*GameSpeed.speed*speed)
	
	pass

func _on_hitbox_hit(other: Area2D) -> void:
	health -= other.damage
	if health <= 0:
		die()
		
func die():
	for i in gem_count:
		call_deferred("create_gem")
		
	killed.emit()
	queue_free()
	
func create_gem():
	var gem = GEM.instantiate()
	get_parent().add_child(gem)
	gem.global_position = global_position
		
