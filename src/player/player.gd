extends Sprite2D

var max_speed := 100.0
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity += input_direction*delta*400
	velocity -= velocity.normalized()*delta*300
	if velocity.length() > max_speed: velocity = velocity.normalized() * max_speed
	
	position += velocity*delta
	pass
