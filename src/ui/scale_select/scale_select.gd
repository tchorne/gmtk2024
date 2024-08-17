extends Node

const SELECT_RECT = preload("res://src/ui/scale_select/select_rect.tscn")

@onready var color_rect: ColorRect = $ColorRect
@onready var select_rect: NinePatchRect = $SelectRect
@onready var game_camera : Camera2D = get_tree().get_first_node_in_group("GameCamera")
@onready var sub_viewport: SubViewport = $"../SubViewportContainer/SubViewport"

var visible := false

func _enter_tree() -> void:
	get_tree().node_added.connect(_on_node_added)
	
func _on_node_added(node: Node):
	if node is ScaleComponent:
		var scale: ScaleComponent = node
		scale.mouse_enter.connect(_on_scale_mouse_enter.bind(scale))
		scale.mouse_exit.connect(_on_scale_mouse_exit.bind(scale))
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("level"):
		toggle()
		
func toggle():
	if not visible:
		toggle_on()
	else:
		toggle_off()
		
func toggle_on():
	visible = true
	color_rect.visible = true
	select_rect.visible = false
	
	GameSpeed.scale_select_factor = 0.05

func toggle_off():
	GameSpeed.scale_select_factor = 1.0
	visible = false
	color_rect.visible = false
	select_rect.visible = false
	pass

func _on_scale_mouse_enter(scale: ScaleComponent):
	var components : Array[ScaleComponent] = []
	components.assign(get_tree().get_nodes_in_group("ScaleComponent"))
	var root: Window = get_tree().root
	
	#for s in components:
		#if s.scale_group == scale.scale_group:
	var s = scale
	var box = SELECT_RECT.instantiate()
	$SelectRects.add_child(box)
	box.size = s.size * sub_viewport.canvas_transform.get_scale()
	box.position = (sub_viewport.canvas_transform * s.position) - box.size/2
	print(box.position)
	
func _on_scale_mouse_exit(_scale: ScaleComponent):
	pass
