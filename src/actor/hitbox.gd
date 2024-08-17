extends Area2D

signal hit(other: Area2D)

func on_hit(other):
	hit.emit(other)

func push(dir):
	if get_parent().has_method('push'):
		get_parent().push(dir)

func _on_area_entered(area: Area2D) -> void:
	on_hit(area)
