extends Node3D

func _ready():
	# Wait a short moment to let everything initialize properly
	await get_tree().create_timer(0.2).timeout
	
	# Ensure XR is initialized
	if not get_viewport().use_xr:
		get_viewport().use_xr = true
	
	# Configure the viewport for menu display
	var menu_viewport = $MenuViewport
	menu_viewport.viewport_size = Vector2(1000, 600)
	menu_viewport.collision_layer = 1048576  # UI Objects layer (layer 20)
	menu_viewport.update_mode = 1  # Update always
	
	# Configure function pointers for UI interaction
	var left_pointer = $XROrigin3D/LeftHandController/FunctionPointer
	var right_pointer = $XROrigin3D/RightHandController/FunctionPointer
	
	# Enable pointers and ensure they can interact with UI
	left_pointer.enabled = true
	right_pointer.enabled = true
	
	# Set collision mask to match the viewport's layer
	left_pointer.collision_mask = 1048576  # Match the viewport's layer
	right_pointer.collision_mask = 1048576  # Match the viewport's layer
	
	# Ensure the menu is properly positioned and animated
	position_menu()
	
	# Make sure VR state is properly set
	if Global:
		Global.set_vr_enabled(true)
	
	# Clear mouse mode
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Connect button signals (wait a bit to ensure the scene instance is ready)
	await get_tree().create_timer(0.5).timeout
	connect_menu_buttons()

func position_menu():
	# Position the menu in front of the player's starting position
	var menu = $MenuViewport
	menu.transform.origin = Vector3(0, 1.8, -2)  # Adjust height and distance as needed
	
	# Add animation for menu appearance
	var tween = create_tween()
	tween.tween_property(menu, "scale", Vector3(1.5, 1.5, 1.5), 0.5).from(Vector3(0.1, 0.1, 0.1))

func connect_menu_buttons():
	# Get the menu interface
	var menu_viewport = $MenuViewport
	var menu_scene = menu_viewport.get_scene_instance()
	
	if menu_scene:
		print("Successfully got menu scene instance")
		
		# Find the buttons by path
		var button1 = menu_scene.get_node_or_null("MarginContainer/VBoxContainer/ButtonContainer/Button")
		var button2 = menu_scene.get_node_or_null("MarginContainer/VBoxContainer/ButtonContainer/Button2")
		
		if button1 and button2:
			print("Found menu buttons, connecting signals")
			
			# Connect button signals directly to our handlers
			if not button1.is_connected("pressed", on_washewicz_button_pressed):
				button1.pressed.connect(on_washewicz_button_pressed)
			
			if not button2.is_connected("pressed", on_fenn_button_pressed):
				button2.pressed.connect(on_fenn_button_pressed)
		else:
			print("Couldn't find menu buttons - check node paths")
			print("Available nodes:", menu_scene.get_node("MarginContainer").get_children())
	else:
		print("Failed to get menu scene instance")

func on_washewicz_button_pressed():
	print("VR: Teleporting to Washewicz Hall")
	get_tree().change_scene_to_file("res://scenes/WH_Floor_1/WH_1_1.tscn")

func on_fenn_button_pressed():
	print("VR: Teleporting to Fenn Hall")
	get_tree().change_scene_to_file("res://scenes/WH_Floor_0/WH_0_8.tscn")

func _process(_delta):
	# Check for key presses even in VR mode
	if Input.is_key_pressed(KEY_ESCAPE):
		exit_vr()

func exit_vr():
	# Exit VR mode
	get_viewport().use_xr = false
	
	# Update global state
	if Global:
		Global.set_vr_enabled(false)
	
	# Return to desktop menu
	get_tree().change_scene_to_file("res://MainMenu.tscn")
