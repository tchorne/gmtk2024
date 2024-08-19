class_name Enemy
extends Sprite2D

signal killed
const WEAPON_STAR = preload("res://src/drops/weapon_star.tscn")
const GEM = preload("res://src/drops/gem.tscn")
const HITFLASH_DURATION = 0.1
const ENEMY_FADEOUT = preload("res://src/enemy/enemy_fadeout.tscn")
@onready var repel_zone: Area2D = $RepelZone
@onready var boss_rim: Sprite2D = $BossRim

static var camera : Camera2D
static var highest_tier_killed := 0

var base_color = Color("ff0000")


var boss_tier := 0
const BOSS_COLORS = [
	Color(1, 1, 1, 0),
	Color(0.373, 0.69, 0.784),
	Color(0.93, 0.912, 0.4),
	Color(0.86, 0.494, 0.103),
	Color(0.59, 0, 0),
	Color(0.525, 0.13, 1),
	Color(0.525, 0.13, 1),
	Color(0.77, 0.231, 0.617)
	
]

var speed := 200.0

var gem_count := 1.0

var max_health := 10.0
var health := max_health

var player: Sprite2D

var velocity : Vector2

var hitflash_duration = 0.0


func _ready():
	get_tree().root.get_node("Main").reset.connect(
		func(): queue_free())
	
	camera = get_tree().get_first_node_in_group("GameCamera")
	player = get_tree().get_first_node_in_group("Player")
	health = max_health
	self_modulate = base_color
	
	for i in boss_tier:
		health *= 2
	boss_rim.self_modulate = BOSS_COLORS[boss_tier]
	
func get_camera_rect():
	var pos = camera.global_position
	var half_size = camera.get_viewport_rect().size * 0.5 / camera.zoom
	half_size *= 1.2
	return Rect2(pos-half_size, half_size*2).abs()

func _process(delta: float) -> void:
	var dir = (player.global_position - global_position).normalized()
	
	var cam_rect : Rect2 = get_camera_rect()
	if global_position.x < cam_rect.position.x: global_position.x += cam_rect.size.x
	if global_position.y < cam_rect.position.y: global_position.y += cam_rect.size.y
	if global_position.x > cam_rect.end.x: global_position.x -= cam_rect.size.x
	if global_position.y > cam_rect.end.y: global_position.y -= cam_rect.size.y
	
	velocity += dir * 5.0 * delta * GameSpeed.speed
	velocity -= velocity * delta * GameSpeed.speed * 2.0
	
	if velocity.length_squared() > 1.0: 
		velocity = lerp(velocity, velocity.normalized(), delta*GameSpeed.speed * 5.0)	
	
	if hitflash_duration > 0:
		hitflash_duration -= delta*GameSpeed.speed
		if hitflash_duration < 0:
			self_modulate = base_color
	
	translate(velocity * speed * GameSpeed.speed * delta * (1.3 ** boss_tier))
	
	for other in repel_zone.get_overlapping_areas():
		if other.get_parent() == self: continue
		if other.get_parent().has_method("push"):
			var d = other.global_position-global_position
			other.get_parent().push(d.normalized() * delta * 10.0)
			
	var rotational_velocity = velocity.dot(dir)
	rotate(rotational_velocity*delta*GameSpeed.speed)

func push(dir: Vector2):
	velocity += dir / (boss_tier+1)

func _on_hitbox_hit(other: Node, damage) -> void:
	health -= damage
	hitflash_duration = HITFLASH_DURATION
	self_modulate = Color.WHITE
	if health <= 0:
		die()
		
func die():
	for i in int(round(gem_count)+(1-1<<boss_tier)):
		call_deferred("create_gem")
	if boss_tier >= 7:
		player.dead = true
		player.invincibility_time = 99999
		get_tree().get_first_node_in_group("Victory").popup()
	elif boss_tier > highest_tier_killed:
		highest_tier_killed += 1
		call_deferred("create_star")
	
	call_deferred("create_fadeout")
	killed.emit()
	queue_free()
	
func create_gem():
	var gem = GEM.instantiate()
	get_parent().add_child(gem)
	gem.global_position = global_position
		
func create_star():
	var star = WEAPON_STAR.instantiate()
	get_parent().add_child(star)
	star.global_position = global_position
	
func create_fadeout():
	var f = ENEMY_FADEOUT.instantiate()
	get_parent().add_child(f)
	f.global_position = global_position
	f.scale = scale
	
