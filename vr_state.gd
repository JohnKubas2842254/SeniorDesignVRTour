extends Node

# Singleton to track VR state
var is_vr_enabled: bool = false


# Function to initialize and enable VR
func initialize_vr():
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface:
		if xr_interface.is_initialized():
			print("OpenXR initialized. Enabling VR...")
			get_viewport().use_xr = true
			is_vr_enabled = true
		else:
			print("OpenXR interface is not initialized properly.")
			is_vr_enabled = false
	else:
		print("OpenXR interface not found.")
		is_vr_enabled = false

# Function to disable VR
func disable_vr():
	get_viewport().use_xr = false
	is_vr_enabled = false

# Add these functions to your existing VrState.gd

func _input(event):
	# Allow toggling fullscreen with F11, Alt+Enter, or ESC
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F11 or (event.keycode == KEY_ENTER and event.alt_pressed):
			toggle_fullscreen()
		# ESC key exits fullscreen
		elif event.keycode == KEY_ESCAPE and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1280, 720))

func toggle_fullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1280, 720))
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
