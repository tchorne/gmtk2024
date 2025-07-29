extends NinePatchRect

var target : ScaleComponent
var transform : Transform2D
@onready var group: Label = $group
@onready var desc: Label = $desc

var tween : Tween

func _process(delta):
	if is_instance_valid(target):
		size = target.size * transform.get_scale()
		position = (transform * target.position) - size/2
	else:
		queue_free()


func init(final_size):
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "size", final_size, 0.2)
	tween.tween_property(group, "visible_ratio", 1.0, 0.2)
	tween.tween_property(desc, "visible_ratio", 1.0, 0.2)
	
	
	pass
