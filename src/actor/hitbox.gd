extends Area2D

signal hit(other: Area2D)

func on_hit(other):
	hit.emit(other)


func _on_area_entered(area: Area2D) -> void:
	on_hit(area)
