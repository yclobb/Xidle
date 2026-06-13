extends Button
var rollsixmult: int = 10
var score = Engine.get_meta("rollscore", 0)
var upgradelevel = 0
var pricelist: Array[int] = [10000000]
var lis: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Upgrade Tree: 1.7\nMore RNG\n10x to DP Gain per 6 Rolled\nUpgrade " + str(upgradelevel) + "/1\nPrice: 1e7\nCurrently: 0X"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	lis = Engine.get_meta("upgradeboughtlist", [])
	Engine.set_meta("rollsixmult", 1)
	if upgradelevel == 1:	
		disabled = true
		add_theme_color_override("font_color", Color.GREEN)
		text = "Upgrade Tree: 1.7\nMore RNG\n10x to DP Gain per 6 Rolled\nUpgrade MAX/1\nPrice: N/A\nCurrently: 10X"
	else:
		remove_theme_color_override("font_color")
		text = "Upgrade Tree: 1.7\nMore RNG\n10x to DP Gain per 6 Rolled\nUpgrade " + str(upgradelevel) + "/1\nPrice: 1e7\nCurrently: 0X"
	if lis.size() < 6:
		visible = false 
		disabled = true
	else:
		visible = true
		disabled = false
	score = Engine.get_meta("rollscore", 0)

func _on_pressed() -> void:
	if upgradelevel < 1:
		if score >= pricelist[upgradelevel]:
			score -= pricelist[upgradelevel]
			Engine.set_meta("rollscore", score)
			rollsixmult *= 10
			Engine.set_meta("rollsixmult", rollsixmult)
			if upgradelevel == 0:
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1
