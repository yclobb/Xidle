extends Button
var score: int = Engine.get_meta("rollscore", 0)
var dpboostsdpmult: float = 0
var base: int = 11
var baseadd: int = 3
var pricelist: Array[int] = [500000000]
var lis: Array = []
var rollmult = Engine.get_meta("rollmultupgrade", 1)
var upgradelevel: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Upgrade Tree: 1.8\nOk...\nDP Boosts DP\nUpgrade 0/1\nPrice: 5e8\nCurrently:"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score = Engine.get_meta("rollscore", 0)
	rollmult = Engine.get_meta("rollmultupgrade", 1)
	lis = Engine.get_meta("upgradeboughtlist", [])
	if score > 1:
		score = Engine.get_meta("rollscore", 0)
		dpboostsdpmult = snapped(pow(log(score), 1.85) / log(base) / log(base+baseadd), 0.01) 
	if upgradelevel < 1:
		text = "Upgrade Tree: 1.8\nOk...\nDP Boosts DP\nUpgrade 0/1\nPrice: 5e8"
		remove_theme_color_override("font_color")
	else:
		add_theme_color_override("font_color", Color.GREEN)
		text = "Upgrade Tree: 1.8\nOk...\nDP Boosts DP\nUpgrade MAX/1\nPrice: N/A\nCurrently: " + str(dpboostsdpmult) + "X"
		Engine.set_meta("dpboostmult", dpboostsdpmult)
	if lis.size() < 7:
		visible = false 
		disabled = true
	else:
		visible = true
		disabled = false
	if lis.size() == 0:
		upgradelevel = 0
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
