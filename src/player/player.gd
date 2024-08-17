extends Sprite2D

var max_speed := 500.0
var velocity := Vector2.ZERO

var gems := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity += input_direction*delta*800* GameSpeed.speed
	velocity -= velocity.normalized()*delta*500 * GameSpeed.speed
	if velocity.length() > max_speed: velocity = velocity.normalized() * max_speed
	
	position += velocity*delta*GameSpeed.speed
	pass


func _on_hitbox_hit(other: Area2D) -> void:
	if other.has_method("collect"):
		collect(other)
		return
		
	

func collect(collectible: Area2D):
	collectible.collect()
	gems += 1
	


func _on_collect_radius_area_entered(area: Area2D) -> void:
	area.moving_to_player = true
	area.p1 = area.global_position
	var vec = (global_position - area.global_position)
	area.p2 = area.global_position + vec.rotated(PI) + vec * randf()
