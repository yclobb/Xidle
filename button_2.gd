extends Button
var price: int = 100
var upgrades: int = 0
var rollmult: float = 0.5
var pricemult: float = 1.25
var totalrollmult: float = 1
var dicemultups: int = 0
@onready var score = Engine.get_meta("rollscore", 0)
var digits: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.set_meta("rollmultupgrade", rollmult)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	upgrades = Engine.get_meta("dicemultups", 0)
	rollmult = Engine.get_meta("rollmultupgrade", 1)
	if int(totalrollmult) == totalrollmult:
		totalrollmult = int(totalrollmult)
	score = Engine.get_meta("rollscore", 0)
	totalrollmult = rollmult * upgrades + 1
	Engine.set_meta("totalrollmult", totalrollmult)
	text = "Upgrade Dice Mult\nPrice:" + str(price) + "\nCurrently: " + str(upgrades * rollmult + 1) + "x"
	digits = len(str(price)) - 1
	if  price > 1000000:
		text = "Upgrade Dice Mult\nPrice:" + str(snappedf(price / pow(10, digits), 0.01)) + "e" + str(digits) + "\nCurrently: " + str(upgrades * rollmult + 1) + "x"

func _on_pressed() -> void:
	if score >= price:
		score -= price
		Engine.set_meta("rollscore", score)
		upgrades += 1
		price = int(pow(pricemult, upgrades) * 100)
		dicemultups += 1
		Engine.set_meta("dicemultups", dicemultups)
	

