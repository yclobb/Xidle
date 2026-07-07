extends Button
var score: int = Engine.get_meta("rollscore", 0)
var base: int = 11
var baseadd: int = 3
var pricelist: Array[float] = [1e11, 1e13, 1e15]
var lis: Array = []
var rollmult = Engine.get_meta("rollmultupgrade", 1)
var upgradelevel: int = 0
var dmgmult: float = Engine.get_meta("dmgmult", 1.0)
var digits: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Upgrade Tree: 1.9\nMore DMG\nDP Boosts Damage Further\nUpgrade 0/3\nPrice: 1e11"
	Engine.set_meta("dmgmult", dmgmult)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	digits = str(pricelist[upgradelevel]).length() - 1
	score = Engine.get_meta("rollscore", 0)
	rollmult = Engine.get_meta("rollmultupgrade", 1)
	lis = Engine.get_meta("upgradeboughtlist", [])
	if score > 1 and upgradelevel > 0:
		dmgmult = log(score)/log(pow(8.25, 5.5 - 1.1*upgradelevel))
	else:
		dmgmult = 1
	Engine.set_meta("dmgmult", dmgmult)
	if upgradelevel < 3:
		text = "Upgrade Tree: 1.9\nMore DMG\nDP Boosts Damage Further\nUpgrade " + str(upgradelevel) + "/3\nPrice: " +  str(snappedf(pricelist[upgradelevel] / pow(10, digits), 0.01)) + "e" + str(digits) + "\nCurrently: " + str(dmgmult) + "X"
		remove_theme_color_override("font_color")
	elif upgradelevel == 3:
		add_theme_color_override("font_color", Color.GREEN)
		text = "Upgrade Tree: 1.9\nMore DMG\nDP Boosts Damage Further\nUpgrade MAX/3\nPrice: N/A\nCurrently: " + str(dmgmult)
	if lis.size() < 8:
		visible = false 
		disabled = true
	else:
		visible = true
		disabled = false
	if lis.size() == 0:
		upgradelevel = 0
func _on_pressed() -> void:
	if upgradelevel < 3:	
		if score >= pricelist[upgradelevel]:
			score -= int(pricelist[upgradelevel])
			Engine.set_meta("rollscore", score)
			if upgradelevel == 0:
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1
