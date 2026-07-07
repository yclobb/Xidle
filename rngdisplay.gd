extends Label
var rollscore = Engine.get_meta("rollscore", 0)
var rngscore: float = Engine.get_meta("rngscore", 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rollscore = Engine.get_meta("rollscore", 0)
	Engine.set_meta("rollscore", 1e14)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(Engine.get_meta("upgradeboughtlist", []))
	if rngscore > 0:
		text = "Total RNG Points: " + str(snappedf(rngscore, 0.1))
	else:
		text = "Total RNG Points: 0"