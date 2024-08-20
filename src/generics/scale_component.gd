class_name ScaleComponent
extends Node

signal scaled

@onready var collision_shape_2d: CollisionShape2D = $MouseDetector/CollisionShape2D
@onready var mouse_detector: Area2D = $MouseDetector
@onready var parent : Node = get_parent()
@export var ui := false
@export var scale_group := &""
@export var select_rectangle : RectangleShape2D = null
@export var oneshot := false
@export var property_scalers : Array[PropertyScaler]


signal mouse_enter
signal mouse_exit

var base_points : Array[Vector2] = []
var size : Vector2
var position  : Vector2

var update_frames := 0
var update_time := 0.0
const UPDATE_FRAMES = 40
const UPDATE_TIME = 0.05

func _ready():
	position = parent.global_position
	collision_shape_2d.shape = select_rectangle
	base_points.append(Vector2(select_rectangle.size.x/2, select_rectangle.size.y/2))
	base_points.append(Vector2(-select_rectangle.size.x/2, select_rectangle.size.y/2))
	base_points.append(Vector2(select_rectangle.size.x/2, -select_rectangle.size.y/2))
	base_points.append(Vector2(-select_rectangle.size.x/2, -select_rectangle.size.y/2))
	mouse_detector.global_position = get_parent().global_position
	
	for scaler in property_scalers:
		scaler.node = get_node(scaler.node_path)
		scaler.get_base_value()
		scaler.scale_property(get_scale())
		
func _on_mouse_detector_mouse_entered() -> void:
	mouse_enter.emit()

func _on_mouse_detector_mouse_exited() -> void:
	mouse_exit.emit()

func _process(delta: float) -> void:
	update_frames -= 1
	update_time -= delta
	position = parent.global_position
	
	if update_frames < 0 and update_time < 0:
		update_frames = UPDATE_FRAMES
		update_time = UPDATE_TIME
		
		if not Engine.is_editor_hint():
			mouse_detector.global_position = parent.global_position
			if base_points.size() > 0:
				var angle = get_parent().global_rotation if get_parent().get("global_rotation") else 0
				var scale = get_parent().scale
				var points : Array[Vector2] = []
				for point in base_points:
					points.append(point.rotated(angle)*scale)
				
				var x1 = points[0].x
				var x2 = points[0].x
				var y1 = points[0].y
				var y2 = points[0].y
				for point in points:
					x1 = min(x1, point.x)
					x2 = max(x2, point.x)
					y1 = min(y1, point.y)
					y2 = max(y2, point.y)
				
				size = Vector2(x2-x1, y2-y1)
				select_rectangle.size = size


func scale():
	for scaler in property_scalers:
		scaler.scale_property(get_scale())
	scaled.emit()

func get_scale() -> int:
	return ScaleManager.scales.get(scale_group, 1)
