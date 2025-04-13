extends Node3D

func _ready():
	print("_ready initialized.")
	Global.pre_hide_xr_nodes()  # Use the singleton to manage XR nodes
	
	# Add a small delay to allow the scene to initialize before enabling XR
	await get_tree().create_timer(1.0).timeout  # Wait for one frame

	# Use the VR singleton to initialize VR
	VrState.initialize_vr()
	
	# Update the behavior of XR-related nodes based on VR state
	update_xr_behavior()

func transition_to_scene(scene_path: String):
	if scene_path:
		# Pre-hide XR-related nodes BEFORE switching scenes
		#pre_hide_xr_nodes()
		print("Pre-hide XR nodes completed. Changing scene...")
		# Perform the scene change
		get_tree().change_scene_to_file(scene_path)

# Function to update the behavior of XR-related nodes
func update_xr_behavior():
	# Access the XR-related nodes
	var left_hand = $XROrigin3D/LeftHandController.get_node_or_null("LeftHand")
	var right_hand = $XROrigin3D/RightHandController.get_node_or_null("RightHand")
	var left_function_pointer = $XROrigin3D/LeftHandController.get_node_or_null("FunctionPointer")
	var right_function_pointer = $XROrigin3D/RightHandController.get_node_or_null("FunctionPointer")
	
	# Update their state using the VR singleton
	if left_hand and left_hand.has_method("set_active"):
		left_hand.set_active(VrState.is_vr_enabled)
	if right_hand and right_hand.has_method("set_active"):
		right_hand.set_active(VrState.is_vr_enabled)
	if left_function_pointer and left_function_pointer.has_method("set_active"):
		left_function_pointer.set_active(VrState.is_vr_enabled)
	if right_function_pointer and right_function_pointer.has_method("set_active"):
		right_function_pointer.set_active(VrState.is_vr_enabled)
