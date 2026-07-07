extends Button
var rngpoints = Engine.get_meta("rngscore", 0)
var upgradelevel: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if upgradelevel == 0:
		text = "Prestige Tree: 1.1\nSUPER BOOST!\nx3 DP and ^1.02 DP, x1.2 DMG\nand -0.01 Cooldown Time\nUpgrade 0/1\nPrice: 1 RNG POINTS"
	elif upgradelevel == 1:
		text = "Prestige Tree: 1.1\nSUPER BOOST!\nx3 DP and ^1.02 DP, x1.2 DMG\nand -0.01 Cooldown Time\nUpgrade 1/1\nPrice: MAX"
	if upgradelevel == 1:
		disabled = true
		add_theme_color_override("font_color", Color.SKY_BLUE)
	else:
		remove_theme_color_override("font_color")
func _on_pressed() -> void:
	if upgradelevel == 0:
		if rngpoints >= 1:
			rngpoints -= 1
			Engine.set_meta("rngscore", rngpoints)
			upgradelevel += 1
			var scoreexponent = Engine.get_meta("rollexponent", 1.0)
			scoreexponent += 1.02
			Engine.set_meta("prestigemult", 3)
			Engine.set_meta("rollexponent", scoreexponent)
			Engine.set_meta("prestigecooldown", 0.01)
