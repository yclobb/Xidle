extends Button
var score = Engine.get_meta("rollscore", 0)
var upgradelevel = 0
var pricelist: Array[int] = [1000000]
var lis: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Upgrade Tree: 1.5\nDouble Every Time\n2x to DP Gain\nUpgrade" + str(upgradelevel) + "/3\nPrice: " + str(pricelist[upgradelevel])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	lis = Engine.get_meta("upgradeboughtlist", [])
	if upgradelevel < 1:
		text = "Upgrade Tree: 1.6\nNew System??\nUnlock Your First Enemy\nUpgrade " + str(upgradelevel) + "/1\nPrice: " + str(pricelist[upgradelevel])
	else:
		text = "Upgrade Tree: 1.6\nNew System??\nUnlock Your First Enemy\nUpgrade MAX/3\nPrice: N/A"
	if upgradelevel == 1:
		disabled = true
		add_theme_color_override("font_color", Color.GREEN)
	else:
		remove_theme_color_override("font_color")
	if upgradelevel == 0:
		for children in get_children():
			if children.name == "TextureButtonEnemy1" or children.name == "InfoButtonEnemy1" or children.name == "DmgButton":
				children.disabled = true
			children.visible = false
	else:
		for children in get_children():
			if children.name == "TextureButtonEnemy1" or children.name == "InfoButtonEnemy1" or children.name == "DmgButton":
				children.disabled = false
			children.visible = true
	if lis.size() < 5:
		disabled = true
	else:
		disabled = false
	score = Engine.get_meta("rollscore", 0)

func _on_pressed() -> void:
	if upgradelevel < 1:
		if score >= pricelist[upgradelevel]:
			score -= pricelist[upgradelevel]
			Engine.set_meta("rollscore", score)
			if upgradelevel == 0:
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1
