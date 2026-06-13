extends Button
var rollmult = Engine.get_meta("rollmultupgrade", 1)
var score = Engine.get_meta("rollscore", 0)
var upgradelevel = 0
var pricelist: Array[int] = [5000]
var lis: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Upgrade Tree: 1.3\nCool! Mult!\n5x to DP Gain\nUpgrade" + str(upgradelevel) + "/1\nPrice: " + str(pricelist)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	lis = Engine.get_meta("upgradeboughtlist", [])
	rollmult = Engine.get_meta("rollmultupgrade", 1)
	if upgradelevel < 1:
		text = "Upgrade Tree: 1.3\nCool! Mult!\n5x to DP Gain\nUpgrade " + str(upgradelevel) + "/1\nPrice: " + str(pricelist[upgradelevel])
	else:
		text = "Upgrade Tree: 1.3\nCool! Mult!\n5x to DP Gain\nUpgrade MAX/1\nPrice: N/A"
	if upgradelevel == 1:
		disabled = true
		add_theme_color_override("font_color", Color.GREEN)
	else:
		remove_theme_color_override("font_color")
	if lis.size() < 2:
		disabled = true
	else:
		disabled = false
	score = Engine.get_meta("rollscore", 0)

func _on_pressed() -> void:
	if upgradelevel < 1:
		if score >= pricelist[upgradelevel]:
			score -= pricelist[upgradelevel]
			Engine.set_meta("rollscore", score)
			rollmult *= 5
			Engine.set_meta("rollmultupgrade", rollmult)
			if upgradelevel == 0:
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1

