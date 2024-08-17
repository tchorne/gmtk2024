extends Sprite2D

var base_max_speed = 500
var max_speed := 500.0
var velocity := Vector2.ZERO
var acceleration = 1.0
@onready var scale_component: ScaleComponent = $ScaleComponent

var gems := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity += input_direction*delta*800* GameSpeed.speed * acceleration
	velocity -= velocity.normalized()*delta*700 * GameSpeed.speed * acceleration
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


func _on_scale_component_scaled() -> void:
	var before = (1 + 0.3*(scale_component.get_scale()-2))
	var after = (1 + 0.3*(scale_component.get_scale()-1))
	max_speed = base_max_speed * after
	acceleration = after
	$CameraZoomScaler.begin_scale(Vector2.ONE*0.25/before, Vector2.ONE*0.25/after)
