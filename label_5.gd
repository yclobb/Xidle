extends Label
var lis: Array = []
var totalrollmult: float = Engine.get_meta("totalrollmult", 1)
var dpboostsdpmult: float = Engine.get_meta("dpboostmult", 1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	lis = Engine.get_meta("upgradeboughtlist")
	var digits = str(totalrollmult).length() - 1
	totalrollmult = Engine.get_meta("totalrollmult", 1)
	dpboostsdpmult = Engine.get_meta("dpboostmult", 1)
	if lis.size() >= 8:
		totalrollmult *= dpboostsdpmult
	if totalrollmult <= 1000000:
		text = "Total Mult: " + str(snapped(totalrollmult, 0.01)) + "X"
	else:
		text = "Total Mult: " + str(snapped((totalrollmult)/pow(10, digits), 0.01)) + "e" + str(digits) + "X"
