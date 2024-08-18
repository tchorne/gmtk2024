extends Sprite2D

@onready var gem_counter: Node = %GemCounter
@onready var scale_component: ScaleComponent = $ScaleComponent
@onready var sound_hurt: AudioStreamPlayer = $SoundHurt

var base_max_speed = 500
var max_speed := 500.0
var velocity := Vector2.ZERO
var small_velocity := Vector2.ZERO

var max_health := 10
var health := max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	small_velocity += input_direction * delta * GameSpeed.speed * 8.0
	
	small_velocity -= small_velocity * delta * GameSpeed.speed * 4.0
	
	if small_velocity.length() > 1.0:
		small_velocity = small_velocity.normalized()
		
	velocity = small_velocity * max_speed
	position += velocity*delta*GameSpeed.speed
	pass


func _on_hitbox_hit(other: Node, damage) -> void:
	if other.has_method("collect"):
		collect(other)
		return
	
	max_health -= damage
	sound_hurt.play()
	if other.get_parent().has_method("die"): other.get_parent().die()
	
		
func collect(collectible: Node):
	collectible.collect()
	gem_counter.add_xp(collectible.xp)
	


func _on_collect_radius_area_entered(area: Area2D) -> void:
	if not area.moving_to_player:
		area.moving_to_player = true
		area.p1 = area.global_position
		var vec = (global_position - area.global_position)
		area.p2 = area.global_position + vec.rotated(PI) + vec * randf()


func _on_scale_component_scaled() -> void:
	var before = (1 + 0.3*(scale_component.get_scale()-2))
	var after = (1 + 0.3*(scale_component.get_scale()-1))
	$CameraZoomScaler.begin_scale(Vector2.ONE*0.25/before, Vector2.ONE*0.25/after)
