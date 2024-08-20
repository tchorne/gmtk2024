extends Weapon

var explosion_timer := 1.0
var placement_interval := 3.0

var placement_timer := 0.0

func set_landmine(x: float, y: float):
	var mine = Area2D.new()
	
	mine.position = Vector2(x, y)
  
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape.radius = 4
	mine.add_child(collision_shape)
	
	add_child(mine)  
	
	await(get_tree().create_timer(explosion_timer))
	explode_mine(mine)

func explode_mine(mine: Area2D):
	mine.queue_free()

func _process(delta):
	placement_timer += delta
	if placement_timer >= placement_interval:
		set_landmine(player.global_position.x, player.global_position.y)
		placement_timer = 0.0
