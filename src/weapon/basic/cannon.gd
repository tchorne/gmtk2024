extends Weapon

var weapon_distance := 325.0

var alpha : float = 0.0

func process_movement(delta):
	alpha += delta * GameSpeed.speed
	position = player.global_position + Vector2.RIGHT.rotated(alpha) * weapon_distance
