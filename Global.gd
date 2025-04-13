extends Node

var vr_enabled: bool = false

# Check if VR is active
func is_vr_enabled() -> bool:
	print("Checking VR state: vr_enabled =", vr_enabled)
	return vr_enabled

# Set VR state (called when headset is detected or manually toggled)
func set_vr_enabled(state: bool):
	vr_enabled = state
	print("VR state set to:", vr_enabled)

func pre_hide_xr_nodes():
	# Access XR-related nodes globally
	var main = get_tree().root.get_node("main")  # Adjust "main" if named differently
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
