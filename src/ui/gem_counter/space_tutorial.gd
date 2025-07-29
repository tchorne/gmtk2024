extends Label

@onready var gem_counter = get_tree().get_first_node_in_group("GemCounter")

var index := 0

var texts = [
	">  SPACE  <",
	" > SPACE < ",
	"  >SPACE<  "
]

func _process(delta: float) -> void:
	if max(ScaleManager.scales[&"Bullet"], ScaleManager.scales[&"Slicer"]) > 1: queue_free()
	visible = gem_counter.current_xp > max(ScaleManager.get_cost(&"Bullet"), ScaleManager.get_cost(&"Slicer"))


func _on_timer_timeout() -> void:
	index = (index + 1) % 3
	text = texts[index]
