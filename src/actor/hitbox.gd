extends Area2D

signal hit(other: Node, damage)

const DAMAGE_INDICATOR = preload("res://src/actor/damage_indicator.tscn")

func on_hit(other, damage:=0.0):
	hit.emit(other, damage)
	if damage > 0.01:
		var di = DAMAGE_INDICATOR.instantiate()
		get_parent().get_parent().add_child(di)
		di.global_position = global_position
		di.init(damage)

func push(dir):
	if get_parent().has_method('push'):
		get_parent().push(dir)

func _on_area_entered(area: Area2D) -> void:
	on_hit(area)
