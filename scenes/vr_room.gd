extends Node3D

var teleport_manager

func _ready():
	# Find or create teleport manager
	teleport_manager = get_node_or_null("/root/teleport_manager")
	if not teleport_manager:
		teleport_manager = load("res://teleport_manger.gd").new()
		get_tree().root.add_child(teleport_manager)
	
	# Initialize VR with null check
	var viewport = get_viewport()
	if viewport and not viewport.use_xr:
		viewport.use_xr = true
	
	# Configure function pointers for UI interaction
	var left_pointer = $XROrigin3D/LeftHandController/FunctionPointer
	var right_pointer = $XROrigin3D/RightHandController/FunctionPointer
	
	# Enable pointers and ensure they can interact with UI
	if left_pointer:
		left_pointer.enabled = true
		left_pointer.collision_mask = 1048576  # UI Objects layer (layer 20)
		print("Left hand pointer configured")
	
	if right_pointer:
		right_pointer.enabled = true
		right_pointer.collision_mask = 1048576  # UI Objects layer (layer 20)
		print("Right hand pointer configured")
	
	# Configure the viewport for menu display
	var menu_viewport = $MenuViewport
	if menu_viewport:
		menu_viewport.viewport_size = Vector2(1000, 600)
		menu_viewport.collision_layer = 1048576  # UI Objects layer (layer 20)
		menu_viewport.update_mode = 1  # Update always
		print("Menu viewport configured successfully")
	
	# Position the menu and connect buttons
	position_menu()
	
	# Connect signals after a short delay
	var tree = get_tree()
	if tree:
		await tree.create_timer(0.5).timeout
		connect_menu_buttons()
	
	# Print debug info
	print("VR Room ready. Current scene: ", get_tree().current_scene.name)
	print_debug_info()

func print_debug_info():
	var viewport = get_viewport()
	if viewport:
		print("Active viewport: ", viewport.name)
		print("XR enabled: ", viewport.use_xr)
	else:
		print("WARNING: Viewport is null during debug info")
	
	var tree = get_tree()
	if tree and tree.current_scene:
		print("Current scene path: ", tree.current_scene.scene_file_path)
	else:
		print("WARNING: Cannot access current scene path")

func position_menu():
	# Position the menu further from the player
	var menu = $MenuViewport
	if menu:
		# Move from -2 to -3 units away (Z-axis)
		# And position it a bit lower for better visibility
		menu.transform.origin = Vector3(0, 1.6, -3)
		
		# Make it larger to compensate for the distance
		menu.scale = Vector3(1.8, 1.8, 1.8)
	else:
		print("ERROR: MenuViewport node not found!")

func connect_menu_buttons():
	var menu_viewport = $MenuViewport
	if not menu_viewport:
		print("ERROR: MenuViewport node not found!")
		return
		
	var menu_scene = menu_viewport.get_scene_instance()
	
	if not menu_scene:
		print("ERROR: No menu scene found!")
		return
	
	# Find the buttons with more detailed debugging
	var button1 = menu_scene.get_node_or_null("MarginContainer/VBoxContainer/ButtonContainer/Button")
	var button2 = menu_scene.get_node_or_null("MarginContainer/VBoxContainer/ButtonContainer/Button2")
	
	if not button1:
		print("ERROR: Button1 not found! Menu structure:")
		print_node_tree(menu_scene)
		return
	
	if not button2:
		print("ERROR: Button2 not found! Menu structure:")
		print_node_tree(menu_scene)
		return
	
	# Clean up any existing connections
	if button1.is_connected("pressed", goto_washewicz):
		button1.disconnect("pressed", goto_washewicz)
	if button2.is_connected("pressed", goto_fenn):
		button2.disconnect("pressed", goto_fenn)
	
	# Connect buttons to direct scene change functions
	button1.pressed.connect(goto_washewicz)
	button2.pressed.connect(goto_fenn)
	
	print("Buttons connected successfully!")

# Debug helper to print node tree
func print_node_tree(node, indent=""):
	if not node:
		print(indent + "NULL NODE")
		return
		
	print(indent + node.name + " (" + node.get_class() + ")")
	for child in node.get_children():
		print_node_tree(child, indent + "  ")

# Direct scene teleport functions - using the same approach as marker scripts
func goto_washewicz():
	print("Button pressed: Teleporting to Washewicz Hall")
	disable_vr_and_change_scene("res://scenes/WH_Floor_1/WH_1_1.tscn")

func goto_fenn():
	print("Button pressed: Teleporting to Fenn Hall")
	disable_vr_and_change_scene("res://scenes/FH_Floor_1/FH_1_11.tscn")

# Simplified scene transition method that matches your working marker approach
func disable_vr_and_change_scene(scene_path):
	print("Preparing to change scene to: " + scene_path)
	
	# Step 1: Turn off XR with null check
	print("Step 1: Disabling XR...")
	var viewport = get_viewport()
	if viewport:
		viewport.use_xr = false
		print("XR disabled successfully")
	else:
		print("WARNING: Viewport is null, cannot disable XR")
	
	# Step 2: Skip one frame to let XR disable properly (with null check)
	var tree = get_tree()
	if tree:
		print("Waiting for process frame...")
		await tree.process_frame
		print("Process frame completed")
	else:
		print("WARNING: SceneTree is null, cannot wait for process frame")
	
	# Step 3: Direct scene change without any staging system or fading
	print("Step 3: Changing scene NOW")
	tree = get_tree()  # Get a fresh reference
	if tree:
		var error = tree.change_scene_to_file(scene_path)
		if error != OK:
			print("ERROR: Failed to change scene, error code: ", error)
		else:
			print("Scene change initiated successfully")
	else:
		print("CRITICAL ERROR: SceneTree is null, cannot change scene!")

# Handle escape key
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		print("ESC pressed, returning to main menu")
		var viewport = get_viewport()
		if viewport:
			viewport.use_xr = false
			print("XR disabled for menu return")
		else:
			print("WARNING: Viewport is null during ESC handling")
		
		var tree = get_tree()
		if tree:
			tree.change_scene_to_file("res://MainMenu.tscn")
		else:
			print("CRITICAL ERROR: SceneTree is null, cannot return to main menu!")

# This function must be called when the scene is about to be unloaded
func _exit_tree():
	print("VR Room being unloaded")
