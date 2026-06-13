extends Button
var score = Engine.get_meta('rollscore', 0)
var pricelist: Array[int] = [500, 2500, 12500]
var upgradelevel: int = 0
var uptree2chanceincrease: float = 0
var lis: Array = []
@onready var rollmultupgrade: float = Engine.get_meta("rollmultupgrade", 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	lis = Engine.get_meta("upgradeboughtlist", []) 
	uptree2chanceincrease = 0.06 * upgradelevel
	rollmultupgrade = Engine.get_meta("rollmultupgrade", 1)
	if upgradelevel < 3:
		text = "Upgrade Tree 1.2\nTip the Odds\n+5% Chance of Rolling 6\nUpgrade " + str(upgradelevel) + "/3\nPrice: " + str(pricelist[upgradelevel])
	else:
		text = "Upgrade Tree 1.2\nTip the Odds\n+5% Chance of Rolling 6\nUpgrade MAX/3\nPrice: N/A"
	score = Engine.get_meta('rollscore', 0)
	if lis.size() < 1:
		disabled = true
	elif upgradelevel < 3:
		disabled = false
	if upgradelevel == 3:
		add_theme_color_override("font_color", Color.GREEN)
	else:
		remove_theme_color_override("font_color")



func _on_pressed() -> void:
	if upgradelevel < 3:
		if score >= pricelist[upgradelevel]:
			uptree2chanceincrease += 0.06
			Engine.set_meta("upgrade2treechanceincrease", uptree2chanceincrease)
			score -= pricelist[upgradelevel]
			Engine.set_meta("rollscore", score)
			if upgradelevel == 0: 
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1
