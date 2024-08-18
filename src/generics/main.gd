extends Node

signal reset


func _on_button_pressed() -> void:
	reset.emit()


func _on_reset() -> void:
	Enemy.highest_tier_killed = 0
