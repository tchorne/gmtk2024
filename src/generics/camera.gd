extends Camera2D

var shake_time_remaining := 0.0
var time_to_next_shake := 0.0
var time_between_shakes := 1.0/20.0
var shake_intensity := 0.0

func shake(intensity, time):
	shake_intensity = intensity
	shake_time_remaining = time
	
func _process(delta: float) -> void:
	shake_time_remaining -= delta
	if shake_time_remaining < 0:
		shake_intensity = 0
	time_to_next_shake -= delta
	if time_to_next_shake < 0:
		time_to_next_shake = time_between_shakes
		offset = Vector2((randf()-1)*shake_intensity, (randf()-1)*shake_intensity)
