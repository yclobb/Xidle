extends Label
var scoregain = Engine.get_meta("scoregain", 0)
var digits: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	scoregain = Engine.get_meta("scoregain", 0)
	digits = str(scoregain).length() - 1
	var sign_ = "+" if scoregain >= 0 else ""
	if scoregain <= 1000000 and scoregain >= 0:
		text = "Last Roll: " + sign_ + str(scoregain)
	elif scoregain < 0:
		text = "Last Roll: " + str(scoregain)
	else:
		text = "Last Roll:" + sign_ + str(snapped(float(scoregain)/pow(10, digits), 0.01)) + "e" + str(digits)
func _on_button_pressed() -> void:
	scoregain = Engine.get_meta("scoregain", 0)
	var fadetween = create_tween()
	fadetween.set_trans(Tween.TRANS_SINE)
	fadetween.set_ease(Tween.EASE_OUT)	
	modulate.a = 1.0
	fadetween.tween_property(self, "modulate:a", 0.0, 0.6)
	await fadetween.finished