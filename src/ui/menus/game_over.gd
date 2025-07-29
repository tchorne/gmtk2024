extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_first_node_in_group("Player").killed.connect(popup)
	
	
func popup():
	visible =true
	


func _on_button_pressed() -> void:
	visible = false
