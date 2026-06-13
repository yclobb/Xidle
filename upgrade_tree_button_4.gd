extends Button
var cooldown: float = 1
var score = Engine.get_meta("rollscore", 0)
var upgradelevel = 0
var pricelist: Array[int] = [3000, 9000]
var lis: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Upgrade Tree: 1.4\nFaster Rolls\n-0.05 Cooldown Time\nUpgrade" + str(upgradelevel) + "/2\nPrice: " + str(pricelist)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	cooldown = Engine.get_meta("cooldown", 1.0)
	lis = Engine.get_meta("upgradeboughtlist", [])
	if upgradelevel < 2:
		text = "Upgrade Tree: 1.4\nFaster Rolls\n-0.05 Cooldown Time\nUpgrade " + str(upgradelevel) + "/2\nPrice: " + str(pricelist[upgradelevel])
	else:
		text = "Upgrade Tree: 1.4\nFaster Rolls\n-0.05 Cooldown Time\nUpgrade MAX/2\nPrice: N/A"
	if upgradelevel == 2:
		disabled = true
		add_theme_color_override("font_color", Color.GREEN)
	else:
		remove_theme_color_override("font_color")
	if lis.size() < 3:
		disabled = true
	else:
		disabled = false
	score = Engine.get_meta("rollscore", 0)

func _on_pressed() -> void:
	if upgradelevel < 2:
		if score >= pricelist[upgradelevel]:
			score -= pricelist[upgradelevel]
			Engine.set_meta("rollscore", score)
			cooldown -= 0.05
			Engine.set_meta("cooldown", cooldown)
			if upgradelevel == 0:
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1


