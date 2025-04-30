extends Node

var vr_enabled: bool = false

# Auto-detect and initialize VR on startup
func _ready():
	# Add a small delay to allow initialization
	call_deferred("detect_and_load_appropriate_scene")

# Detect VR hardware and load appropriate scene
func detect_and_load_appropriate_scene():
	await get_tree().create_timer(0.3).timeout
	
	# Check for VR headset
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("VR headset detected - initializing VR mode")
		vr_enabled = true
		get_tree().change_scene_to_file("res://scenes/VR_Room.tscn")
	else:
		# Try to initialize XR
		if xr_interface and xr_interface.initialize():
			await get_tree().create_timer(0.5).timeout
			if xr_interface.is_initialized():
				print("VR initialized - loading VR room")
				vr_enabled = true
				get_tree().change_scene_to_file("res://scenes/VR_Room.tscn")
				return
		
		# Fall back to desktop mode if VR not available
		print("No VR detected - launching desktop menu")
		vr_enabled = false
		get_tree().change_scene_to_file("res://MainMenu.tscn")

# Check if VR is active
func is_vr_enabled() -> bool:
	return vr_enabled

# Set VR state (called when headset is detected or manually toggled)
func set_vr_enabled(state: bool):
	vr_enabled = state
	print("VR state set to:", vr_enabled)

func pre_hide_xr_nodes():
	# Access XR-related nodes globally
	var main = get_tree().root.get_node_or_null("main")  # Adjust "main" if named differently
	if main:
		var left_hand = main.get_node_or_null("XROrigin3D/LeftHandController/LeftHand")
		var right_hand = main.get_node_or_null("XROrigin3D/RightHandController/RightHand")
		var left_FP = main.get_node_or_null("XROrigin3D/LeftHandController/FunctionPointer")
		var right_FP = main.get_node_or_null("XROrigin3D/RightHandController/FunctionPointer")
		if left_hand:
			left_hand.visible = false
		if right_hand:
			right_hand.visible = false
		if right_FP:
			right_FP.visible = false
		if left_FP:
			left_FP.visible = false
