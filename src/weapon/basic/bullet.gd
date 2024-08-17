extends Area2D

@onready var scale_component: ScaleComponent = $ScaleComponent

var speed := 2000.0
var damage := 1.01
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector2.RIGHT.rotated(rotation)*delta*speed*GameSpeed.speed)
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("on_hit"):
		area.on_hit(self)
		queue_free()
	if area.has_method("push"):
		area.push(Vector2.RIGHT.rotated(rotation)*5000)
