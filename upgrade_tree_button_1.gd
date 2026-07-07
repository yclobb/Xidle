extends Button

var score = Engine.get_meta('rollscore', 0)
var pricelist: Array[int] = [300, 1000, 3000, 5000, 8000]
var upgradelevel: int = 0
var upgradeamount: float = 0.15
var lis: Array = []
@onready var rollmultupgrade: float = Engine.get_meta("rollmultupgrade", 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.set_meta('upgradeboughtlist', [])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	lis = Engine.get_meta("upgradeboughtlist", [])
	rollmultupgrade = Engine.get_meta("rollmultupgrade", 1)
	if upgradelevel < 5:
		text = "Upgrade Tree 1.1\nNever Too Much Mult\n+" + str(upgradeamount) + " Mult Gain From Dice Mult\nUpgrade " + str(upgradelevel) + "/5\nTotal: +"+ str(upgradeamount*upgradelevel) + "\nPrice: " + str(pricelist[upgradelevel])
	else:
		text = "Upgrade Tree 1.1\nNever Too Much Mult\n+" + str(upgradeamount) + " Mult Gain From Dice Mult\nUpgrade MAX/5\nTotal: +"+ str(upgradeamount*upgradelevel) + "\nPrice: N/A"
	score = Engine.get_meta('rollscore', 0)
	if upgradelevel == 5:
		add_theme_color_override("font_color", Color.GREEN)
	else:
		remove_theme_color_override("font_color")
	if lis.size() == 0:
		upgradelevel = 0


func _on_pressed() -> void:	
	if upgradelevel < 5:
		if score >= pricelist[upgradelevel]:
			rollmultupgrade += upgradeamount
			Engine.set_meta("rollmultupgrade", rollmultupgrade)
			score -= pricelist[upgradelevel]
			Engine.set_meta("rollscore", score)
			if upgradelevel == 0:
				lis = Engine.get_meta("upgradeboughtlist", []) 
				lis.append(1)
				Engine.set_meta("upgradeboughtlist", lis)
			upgradelevel += 1
