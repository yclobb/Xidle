extends Button
var score = Engine.get_meta("rollscore", 0)
var rngpoints: float = 0.0
var rngscore: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	## lets make a formula - must be logarithmic so it scales well , well i already made one so i guess this comment is redundant but i will keep it here for sentimental purposes
	
#next feature 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.get_meta("lis", []).size() < 9:
		disabled = true
		visible = false
	else:
		disabled = false
		visible = true
	score = Engine.get_meta("rollscore", 0)
	if rngpoints == 0:
		if score > 0:
			text = "THE GREAT RESET \n(RNGIFY)\nYou will lose all progress other than enemy upgrades\nRNGIFY FOR 0 RNG POINTS\nDistance to RNGIFY: " + str(snappedf((log(score)/log(10))/12, 0.001)*100) + "%"
		else:
			text = "THE GREAT RESET \n(RNGIFY)\nYou will lose all progress other than enemy upgrades\nRNGIFY FOR 0 RNG POINTS\nDistance to RNGIFY: 0%"
	else:
		text = "THE GREAT RESET \n(RNGIFY)\nYou will lose all progress other than enemy upgrades\nRNGIFY FOR " + str(snappedf(rngpoints, 0.1)) + " RNG POINTS"
	Engine.set_meta("rngscore", rngscore)
	if score >= 2e12:
		rngpoints = pow(1.085, log(score)/log(7e9)) * pow(log((score/1.09 + 1)/1.8e14)/log(4), 2.72) + 1
	elif score >= 1e12:
		rngpoints = 1
	else:
		rngpoints = 0
	if rngscore >= 1:
		for child in get_children(true):
			child.visible = true
			if child is Button:
				child.disabled = false
	else:
		for child in get_children(true):
			child.visible = false
			if child is Button:
				child.disabled = true
func _on_pressed() -> void:
	if rngpoints >= 1:
		Engine.set_meta("upgradeboughtlist", [])
		Engine.set_meta("rollmultupgrade", 1)
		Engine.set_meta("upgrade2treechanceincrease", 0.0)
		Engine.set_meta("cooldown", 1.0)
		Engine.set_meta("rollsixmult", 1)
		Engine.set_meta("dpboostmult", 1)
		Engine.set_meta("dmgmult", 1.0)
		rngscore += snappedf(rngpoints, 0.1)
		Engine.set_meta("rngscore", rngscore)
		Engine.set_meta("rollscore", 0)
		