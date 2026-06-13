extends Button
var score = Engine.get_meta("rollscore", 0)
var price: int = 1000
var diceamount: int = 1
var digits: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = Engine.get_meta("rollscore", 0)
	
# Called every frame. 'delta' is the elapsed timed since the previous frame.
func _process(_delta: float) -> void:
	score = Engine.get_meta("rollscore", 0)
	Engine.set_meta("diceamount", diceamount)
	digits = len(str(price)) - 1
	if  price > 1000000:
		if diceamount < 5:
			text = "Upgrade Dice Mult\nPrice:" + str(snappedf(price / pow(10, digits), 0.01)) + "e" + str(digits) + "\nCurrently: " + str(diceamount)
		else:
			add_theme_color_override("font_color", Color.GREEN)
			text = "Upgrade Dice Mult\nPrice:" + str(snappedf(price / pow(10, digits), 0.01)) + "e" + str(digits) + "\nCurrently: MAX"
	else:
		if diceamount < 5:
			text = "Dice Amount\nPrice:" + str(price) + "\nCurrently: " + str(diceamount)
		else:
			add_theme_color_override("font_color", Color.GREEN)
			text = "Dice Amount\nPrice:" + str(price) + "\nCurrently: MAX"

func _on_pressed() -> void:
	if score >= price:
		score -= price
		Engine.set_meta("rollscore", score)
		diceamount += 1
		price *= int(pow(10, diceamount))

