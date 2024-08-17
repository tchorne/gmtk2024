extends NinePatchRect

var target : ScaleComponent
var transform : Transform2D

func _process(delta):
	if is_instance_valid(target):
		size = target.size * transform.get_scale()
		position = (transform * target.position) - size/2
	else:
		queue_free()
