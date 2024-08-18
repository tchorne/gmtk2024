extends Label

@export var alpha_curve : Curve

var velocity := Vector2.ZERO
var lifetime := 0.5
var max_lifetime := 4.0

func init(damage):
	text = str(int(damage))
	lifetime *= remap(damage, 0, 100, 1, 4)
	max_lifetime = lifetime
	add_theme_font_size_override("font_size", int(75*remap(damage, 0, 100, 1, 4)))
	add_theme_color_override("font_color", 
	lerp(Color(1, 1, 1), Color(1, 0.29, 0.29), inverse_lerp(0, 100, damage))
	)
	velocity = Vector2(randf_range(-100, 100), -600)
	global_position += Vector2.RIGHT.rotated(randf()*TAU) * randf() * 100
func _process(delta: float) -> void:
	velocity = lerp(velocity, Vector2.ZERO, delta*GameSpeed.speed)
	global_position += velocity * delta * GameSpeed.speed
	lifetime -= delta * GameSpeed.speed
	if lifetime < 0:
		queue_free()
	var t = inverse_lerp(max_lifetime, 0, lifetime)
	modulate.a = alpha_curve.sample_baked(t)
	
