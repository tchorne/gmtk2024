extends TextureRect

var t := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	
	position.x = sin(t*TAU) * 8
