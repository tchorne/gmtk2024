extends Control

@onready var credits_labels = [
	$Label2,
	$Label3,
	$Label4
]

@onready var stats_labels = [
	$Label5,
	$Label6,
	$Label7,
	$Label8,
	$Label9
]

var stats_names = [
	"kills",
	"xp",
	"revives",
	"time",
	"scales"
]

func popup():
	visible = true
	for i in 5:
		stats_labels[i].modulate.a = 0
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
		tween.tween_property(stats_labels[i], "modulate", Color.WHITE, 2.0 + 0.6*i)
		tween.tween_property(stats_labels[i], "position", Vector2(600, 0), 2.0 + 0.6*i).as_relative()
		stats_labels[i].text += str(int(GameStats.get(stats_names[i])))
	for i in 3:
		stats_labels[i].modulate.a = 0
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
		tween.tween_property(credits_labels[i], "modulate", Color.WHITE, 2.0 + 0.6*i)
		tween.tween_property(credits_labels[i], "position", Vector2(-600, 0), 2.0 + 0.6*i).as_relative()
