extends Sprite2D

var lifetime := 0.5

func _process(delta: float) -> void:
	lifetime -= delta * GameSpeed.speed
	if lifetime < 0:
		queue_free()
	material.set_shader_parameter("t", inverse_lerp(0.5, 0, lifetime))
