extends Sprite2D

signal killed

const GEM = preload("res://src/drops/gem.tscn")
const HITFLASH_DURATION = 0.1

@onready var repel_zone: Area2D = $RepelZone
@onready var boss_rim: Sprite2D = $BossRim

var base_color = Color("ff0000")


var boss_tier := 0
var boss_colors = [
	Color(1, 1, 1, 0),
	Color(0.373, 0.69, 0.784),
	Color(0.93, 0.912, 0.4),
	Color(0.86, 0.494, 0.103),
	Color(0.59, 0, 0),
	Color(0.525, 0.13, 1)
]

var speed := 200.0

var gem_count := 1.0

var max_health := 10.0
var health := max_health

var player: Sprite2D

var velocity : Vector2

var hitflash_duration = 0.0

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	health = max_health
	self_modulate = base_color
	
	for i in boss_tier:
		health *= 4
	boss_rim.self_modulate = boss_colors[boss_tier]
	
	
func _process(delta: float) -> void:
	var dir = (player.global_position - global_position).normalized()
	
	velocity += dir * 5.0 * delta
	velocity -= velocity * delta * GameSpeed.speed
	if velocity.length_squared() > 1.0: velocity = velocity.normalized()
	
	if hitflash_duration > 0:
		hitflash_duration -= delta*GameSpeed.speed
		if hitflash_duration < 0:
			self_modulate = base_color
	
	translate(velocity * speed * GameSpeed.speed * delta)
	
	for other in repel_zone.get_overlapping_areas():
		if other.get_parent() == self: continue
		if other.get_parent().has_method("push"):
			var d = other.global_position-global_position
			other.get_parent().push(d.normalized() * delta * 100.0)

func push(dir: Vector2):
	velocity += dir

func _on_hitbox_hit(other: Node, damage) -> void:
	health -= damage
	hitflash_duration = HITFLASH_DURATION
	self_modulate = Color.WHITE
	if health <= 0:
		die()
		
func die():
	for i in int(round(gem_count)):
		call_deferred("create_gem")
		
	killed.emit()
	queue_free()
	
func create_gem():
	var gem = GEM.instantiate()
	get_parent().add_child(gem)
	gem.global_position = global_position
		
