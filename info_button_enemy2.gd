extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_hover() -> void:
	$RichTextLabel.visible = true


func _on_not_hover() -> void:
	$RichTextLabel.visible = false
