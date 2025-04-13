extends Node

var is_vr_enabled: bool = false

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
