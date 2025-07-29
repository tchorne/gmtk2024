extends Node2D

@onready var mat: ParticleProcessMaterial = $GPUParticles2D.process_material
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var initial_speed := 1.0 : set=speed_set
var particle_scale := 15.0 : set=scale_set
var lifetime = 0.7
var done_damage := false

func _process(delta: float) -> void:
	lifetime -= delta * GameSpeed.speed
	gpu_particles_2d.speed_scale = GameSpeed.speed
	#gpu_particles_2d.fixed_fps = int(30/GameSpeed.speed)
	if lifetime < 0.4 and not done_damage:
		do_damage()
	if lifetime < 0:
		queue_free()

func do_damage():
	done_damage = true
	if $ScalePivot/Area2D/ScaleComponent.get_scale() > 1:
		for hitbox in $ScalePivot/Area2D.get_overlapping_areas():
			if hitbox.has_method("on_hit"):
				hitbox.on_hit(self, 1)

func speed_set(new):
	initial_speed = new
	if mat:
		mat.initial_velocity_min = 50 * new
		mat.initial_velocity_max = 100 * new


func scale_set(new):
	particle_scale = new
	if mat:
		mat.scale_min = 2*particle_scale
		mat.scale_max = 2*particle_scale

func _ready():
	mat.initial_velocity_min = 50 * initial_speed
	mat.initial_velocity_max = 100 * initial_speed
	mat.scale_min = 2*particle_scale
	mat.scale_max = 2*particle_scale
	$ScalePivot/Area2D
