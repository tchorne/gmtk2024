extends Area2D

signal hit(other: Node, damage)

func on_hit(other, damage:=1.0):
	hit.emit(other, damage)

func push(dir):
	if get_parent().has_method('push'):
		get_parent().push(dir)

func _on_area_entered(area: Area2D) -> void:
	on_hit(area)
