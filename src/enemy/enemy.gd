extends Sprite2D

var max_health := 10.0
var health := max_health

func _process(delta: float) -> void:
	pass

func _on_hitbox_hit(other: Area2D) -> void:
	health -= other.damage
