extends Label

var score: int = 0

var digits: int = 0

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	score = Engine.get_meta("rollscore", 0)
	digits = len(str(score)) - 1
	if score <= 1000000:
		text = "Total DP:" + str(score)
	else:
		text = "Total DP:" + str(snapped(float(score)/pow(10, digits), 0.01)) + "e" + str(digits)



func _on_hovered() -> void:
	pass # Replace with function body.
