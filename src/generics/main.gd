extends Node

signal reset

var debug = true
func _on_button_pressed() -> void:
	reset.emit()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_F2) and debug:
		get_tree().get_first_node_in_group("Victory").popup()
		debug = false
		
func _on_reset() -> void:
	Enemy.highest_tier_killed = 0
	GameStats.revives += 1
