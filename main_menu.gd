extends Control

var fullscreen_toggle_cooldown = false

func _ready():
	# Connect buttons to the functions
	$MarginContainer/VBoxContainer/ButtonContainer/Button.pressed.connect(_on_Button_pressed)
	$MarginContainer/VBoxContainer/ButtonContainer/Button2.pressed.connect(_on_Button2_pressed)
	
	# Set initial window state
	await get_tree().create_timer(0.1).timeout
	if not DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		set_fullscreen(true)
	
	# Keep cursor visible
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	# Handle fullscreen toggle keys
	if event is InputEventKey and event.pressed and not fullscreen_toggle_cooldown:
		if event.keycode == KEY_F11 or (event.keycode == KEY_ENTER and event.alt_pressed):
			toggle_fullscreen()
		elif event.keycode == KEY_ESCAPE and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			set_fullscreen(false)

func toggle_fullscreen():
	enable_toggle_cooldown()
	set_fullscreen(DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN)

func set_fullscreen(enable: bool):
	if enable:
		# Multi-step approach to ensure proper fullscreen
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		await get_tree().create_timer(0.05).timeout
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED) 
		await get_tree().create_timer(0.05).timeout
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		# Restore windowed mode
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		await get_tree().create_timer(0.05).timeout
		DisplayServer.window_set_size(Vector2i(1280, 720))
		
		# Center window
		var screen_size = DisplayServer.screen_get_size()
		var window_size = DisplayServer.window_get_size()
		DisplayServer.window_set_position((screen_size - window_size) / 2)

func enable_toggle_cooldown():
	fullscreen_toggle_cooldown = true
	await get_tree().create_timer(0.5).timeout
	fullscreen_toggle_cooldown = false

# Button event handlers
func _on_Button_pressed():
	get_tree().change_scene_to_file("res://scenes/WH_Floor_1/WH_1_1.tscn")

func _on_Button2_pressed():
	get_tree().change_scene_to_file("res://scenes/WH_Floor_0/WH_0_8.tscn")
