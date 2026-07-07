extends Button
var gold: int = Engine.get_meta("gold", 0)
var price: int =  100
var damageadd: float = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	gold = Engine.get_meta("gold", 0)
func _on_pressed() -> void:
	if gold >= price:
		gold -= price
		Engine.set_meta("gold", gold)
		Engine.set_meta("dmgadd", damageadd)
