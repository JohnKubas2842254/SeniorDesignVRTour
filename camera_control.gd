extends Camera3D

var dragging := false
var last_mouse_position := Vector2()
@export var rotation_speed := 0.005  # Adjust sensitivity

func _input(event):
	# Start dragging when left mouse button is pressed
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_position = event.position

	# Rotate when dragging
	if event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_position
		last_mouse_position = event.position

		# Rotate the camera based on mouse movement
		rotate_y(-delta.x * rotation_speed)  # Left/Right rotation
		#rotate_x(-delta.y * rotation_speed)  # Up/Down rotation

		# Clamp vertical rotation to prevent flipping
		rotation.x = clamp(rotation.x, deg_to_rad(-60), deg_to_rad(60))  # Limit tilt
