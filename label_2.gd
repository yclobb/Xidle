extends Label

var numb: Array[int] = []
var diceamount: int = Engine.get_meta("diceamount", 1)
var totalrollmult = Engine.get_meta("totalrollmult", 1)
var textstring = "Rolled:"
var lis: Array = []
# timer func: await get_tree().create_timer(amount of wait time).timeout
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.set_meta("rollscore", 1000000000000)
	pass # Replace with function body.

# currently adding dieamount is a bit buggy, and im confused af current progress: fix stuff that is in delta loops
# to make it not too slow
func _process(_delta: float) -> void:
	totalrollmult = Engine.get_meta("totalrollmult", 1)
	diceamount = Engine.get_meta("diceamount", 1)
	numb = Engine.get_meta("numb", []) as Array[int]
	textstring = "Rolled:"
	for n in range(diceamount):
		var value = 0
		if n < numb.size():
			if totalrollmult != 0:
				value = int(numb[n])
			else:
				value = numb[n]
		textstring += (" " if n == 0 else " * ") + str(value)
	text = textstring
	if numb.count(6 * totalrollmult) > 0:
		add_theme_color_override("font_color", Color("#ffd800"))
	else:
		remove_theme_color_override("font_color")
# quality of life changes
# make it so that 1.5 + 1.5 becomes 3 instead of 2 because of int conversion
