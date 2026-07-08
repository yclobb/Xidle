extends Camera2D
@export var cameraspeed: int = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var inpvector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_key_pressed(KEY_A):
		inpvector.x -= 1.0
	if Input.is_key_pressed(KEY_D):
		inpvector.x += 1.0
	if Input.is_key_pressed(KEY_W):
		inpvector.y -= 1.0
	if Input.is_key_pressed(KEY_S):
		inpvector.y += 1.0

	position += inpvector * cameraspeed * delta

