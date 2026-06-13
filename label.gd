extends Label
var lis: Array = []
var currentcombo: Array[int] = []
var textstring = "Current Combo:"
var clicks: int = 0		
var numb: Array = Engine.get_meta("numb", [])
func _ready() -> void:
	text = textstring

func _process(_delta: float) -> void:
	currentcombo.assign(Engine.get_meta("currentcombo", [1]))
	lis = Engine.get_meta("upgradeboughtlist", [])
	numb = Engine.get_meta("numb", [])
	# Reset the text string at the start of the frame
	textstring = "Current Combo: "
	
	for i in (currentcombo.size()):
		if i == 0:
			textstring += str(currentcombo[i]) + "X"
		else:
			textstring += " * " + str(currentcombo[i]) + "X"
	if lis.size() >= 7:
		textstring += " * " + str(pow(10, numb.count(6))) + "X (UT-7)"
	
	text = textstring

		
		
