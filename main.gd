extends Node3D

func _ready():
	print("WH_1_1 Loaded! Preparing VR mode...")
	
	# Add a small delay to allow the scene to initialize before enabling XR
	await get_tree().create_timer(1.0).timeout  # Wait for one frame
	
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface:
		if xr_interface.is_initialized():
			print("OpenXR initialized. Enabling VR...")
			get_viewport().use_xr = true
		else:
			print("OpenXR interface is not initialized properly.")
	else:
		print("OpenXR interface not found.")


func transition_to_scene(scene_path: String):
	if scene_path:
		get_tree().change_scene_to_file(scene_path)


func _on_leftbody_shape_area_entered(area: Area3D) -> void:
	pass # Replace with function body.


func _on_backward_body_shape_area_entered(area: Area3D) -> void:
	pass # Replace with function body.


func _on_forwardbody_shape_area_entered(area: Area3D) -> void:
	pass # Replace with function body.


func _on_rightbody_shape_area_entered(area: Area3D) -> void:
	pass # Replace with function body.
