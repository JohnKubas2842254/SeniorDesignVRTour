extends Node

# Singleton to track VR state
var is_vr_enabled: bool = false
var fullscreen_toggle_cooldown: bool = false

func _ready():
	print("VR State singleton initialized")
	# Set high process priority to ensure input handling
	process_priority = -100

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

func _input(event):
	# Prevent processing during cooldown
	if fullscreen_toggle_cooldown:
		return
		
	# Allow toggling fullscreen with F11, Alt+Enter, or ESC
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F11 or (event.keycode == KEY_ENTER and event.alt_pressed):
			print("F11/Alt+Enter pressed, toggling fullscreen")
			toggle_fullscreen()
		# ESC key exits fullscreen
		elif event.keycode == KEY_ESCAPE and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			print("ESC pressed, exiting fullscreen")
			exit_fullscreen()

# Robust fullscreen toggle function with proper state handling
func toggle_fullscreen():
	enable_toggle_cooldown()
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		exit_fullscreen()
	else:
		enter_fullscreen()

# Function to exit fullscreen with reliable sequence
func exit_fullscreen():
	# Multi-step approach for reliable exiting fullscreen
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	await get_tree().create_timer(0.1).timeout
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	await get_tree().create_timer(0.1).timeout
	
	# Set to a standard window size
	DisplayServer.window_set_size(Vector2i(1280, 720))
	
	# Center the window on screen
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	var window_position = (screen_size - window_size) / 2
	DisplayServer.window_set_position(window_position)
	
	print("Exited fullscreen mode")

# Function to enter fullscreen with reliable sequence
func enter_fullscreen():
	# Multi-step approach for reliable entering fullscreen
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	await get_tree().create_timer(0.1).timeout
	
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	await get_tree().create_timer(0.1).timeout
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	await get_tree().create_timer(0.1).timeout
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	print("Entered fullscreen mode")

# Prevent rapid toggling by adding a cooldown
func enable_toggle_cooldown():
	fullscreen_toggle_cooldown = true
	await get_tree().create_timer(0.5).timeout
	fullscreen_toggle_cooldown = false
