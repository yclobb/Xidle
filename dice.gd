extends RigidBody3D

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	print("kamikaze boi")
	queue_free() # Destroys the object safely

