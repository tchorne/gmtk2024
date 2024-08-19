extends Weapon

var weapon_distance := 525.0

var alpha : float = 0.0
var beta : float = 0.0

func process_movement(delta):
	beta += delta * GameSpeed.speed
	alpha += delta * GameSpeed.speed * 0.5
	position = player.global_position + Vector2.RIGHT.rotated(alpha) * weapon_distance * sin(alpha*4)
