extends Label
var gold: float = 0
var digits: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gold = Engine.get_meta("gold", 0)
	add_theme_color_override("font_color", Color("#ffd800"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	gold = Engine.get_meta("gold", 0)
	text = "Gold:" + str(gold)
	digits = str(gold).length() - 1
	if gold <= 1000000:
		text = "Gold:" + str(gold)
	else:
		text = "Gold:" + str(snapped(float(gold)/pow(10, digits), 0.01)) + "e" + str(digits)

