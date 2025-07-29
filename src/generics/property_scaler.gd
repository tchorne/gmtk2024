class_name PropertyScaler
extends Resource

@export var node_path : NodePath = ^".."
@export var property : StringName 
@export var scale_amount : float = 2.0
@export var exponential : bool = false

var base_value

var node : Node

func get_base_value():
	base_value = node.get(property)

func scale_property(value):
	if is_instance_valid(node):
		if exponential:
			node.set(property, base_value * (scale_amount ** (value-1)))
		else:
			node.set(property, base_value * (1 + ((scale_amount-1) * (value-1))))
			
