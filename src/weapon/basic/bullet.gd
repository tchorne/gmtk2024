extends Area2D

@onready var scale_component: ScaleComponent = $ScaleComponent
const BULLET_EXPLODE = preload("res://src/weapon/basic/bullet_explode.tscn")
var speed := 2000.0
var damage := 1.01
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector2.RIGHT.rotated(rotation)*delta*speed*GameSpeed.speed)
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("on_hit"):
		area.on_hit(self, damage)
		
		call_deferred("create_explosion")
		
		queue_free()
	if area.has_method("push"):
		area.push(Vector2.RIGHT.rotated(rotation)*2)

func create_explosion():
	var e = BULLET_EXPLODE.instantiate()
	e.rotation = rotation
	e.global_position = global_position
	get_parent().add_child(e)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
