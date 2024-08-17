extends Area2D

signal hit(other: Area2D)

func on_hit(other):
	hit.emit(other)
