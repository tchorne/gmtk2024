extends Node

const SELECT_RECT = preload("res://src/ui/scale_select/select_rect.tscn")

@onready var color_rect: ColorRect = $ColorRect
@onready var select_rect: NinePatchRect = $SelectRect
@onready var game_camera : Camera2D = get_tree().get_first_node_in_group("GameCamera")
@onready var sub_viewport: SubViewport = $"../SubViewportContainer/SubViewport"
@onready var game: Node2D = $"../SubViewportContainer/SubViewport/Game"
@onready var xp_bar = get_tree().get_first_node_in_group("XPBar")
@onready var gem_counter = get_tree().get_first_node_in_group("GemCounter")

var visible := false
var previous_group: StringName = &""
var previous_component : ScaleComponent
var selected_cost := 0.0

func _enter_tree() -> void:
	for node in get_tree().get_nodes_in_group("ScaleComponent"):
		_on_node_added(node)
	get_tree().node_added.connect(_on_node_added)
	
func _on_node_added(node: Node):
	if node is ScaleComponent:
		var scale: ScaleComponent = node
		scale.mouse_enter.connect(_on_scale_mouse_enter.bind(scale))
		scale.mouse_exit.connect(_on_scale_mouse_exit.bind(scale))
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("level"):
		toggle()
	if InputHandler.input_owner == InputHandler.SCALE_SELECT:
		if event.is_action_pressed("primary"):
			if visible:
				scale_current_group()
			
		
func toggle():
	if not visible:
		toggle_on()
	else:
		toggle_off()
		
func toggle_on():
	visible = true
	color_rect.visible = true
	select_rect.visible = false
	InputHandler.scale_select = true
	GameSpeed.scale_select_factor = 0.02

func toggle_off():
	GameSpeed.scale_select_factor = 1.0
	visible = false
	InputHandler.scale_select = false
	color_rect.visible = false
	select_rect.visible = false
	switch_group(&"")
	pass

func switch_group(group: StringName):
	if group == previous_group: return
	previous_group = group
	
	for box in $SelectRects.get_children():
		box.queue_free()
	if group != &"":
		$blip_1.play()
	
	var components : Array[ScaleComponent] = []
	components.assign(get_tree().get_nodes_in_group("ScaleComponent"))
	var root: Window = get_tree().root
	
	var group_data = ScaleManager.indexed_groups.get(group)
	var cost = ScaleManager.get_cost(group)
	xp_bar.update_cost(cost)
	
	var col = Color("00b303") if cost <= gem_counter.current_xp else Color.RED
	
	for s in components:
		if s.scale_group == group:
			var vp = get_viewport() if s.ui else sub_viewport
			var box = SELECT_RECT.instantiate()
			$SelectRects.add_child(box)
			box.init( s.size * vp.canvas_transform.get_scale() )
			box.modulate = col
			if s == previous_component:
				box.group.text = group_data.name
				box.desc.text = group_data.desc
			else:
				box.group.text = ""
				box.desc.text = ""
			
			box.position = (vp.canvas_transform * s.position) - box.size/2
			box.target = s
			box.transform = vp.canvas_transform
			
func _on_scale_mouse_enter(scale: ScaleComponent):
	if not visible: return
	#switch_group(scale.scale_group)
	pass

func _on_scale_mouse_exit(scale: ScaleComponent):
	#switch_group(&"")
	pass
	
func scale_current_group():
	if previous_group != &"":
		var cost = ScaleManager.get_cost(previous_group)
		if cost > gem_counter.current_xp:
			$blip_2.pitch_scale = 0.5	
			$blip_2.play()
		else:
			gem_counter.add_xp(-cost)
			ScaleManager.increase_scale(previous_group)
			var components : Array[ScaleComponent] = []
			components.assign(get_tree().get_nodes_in_group("ScaleComponent"))
			for s in components:
				if s.scale_group == previous_group:
					s.scale()
			$blip_2.pitch_scale = 1.0	
			$blip_2.play()
		
		
	toggle_off()
		
	
	

func _physics_process(_delta: float) -> void:
	if visible:
		var query = PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		query.collide_with_bodies = false
		query.collision_mask = 1 << 7
		
		var ui_space_id = $"../UI".get_world_2d().space
		var ui_space = PhysicsServer2D.space_get_direct_state(ui_space_id)
		query.position = $"../UI".get_global_mouse_position()
		var result = ui_space.intersect_point(query)
		
		if result.size() > 0:
			previous_component = result[0]['collider'].get_parent()
			switch_group(previous_component.scale_group)
			return
		
		var space_id = game.get_world_2d().space
		var space_state = PhysicsServer2D.space_get_direct_state(space_id)
		query.position = game.get_global_mouse_position()
		
		result = space_state.intersect_point(query)
		if result.size() == 0:
			switch_group(&"")
		else:
			previous_component = result[0]['collider'].get_parent()
			switch_group(previous_component.scale_group)
			
