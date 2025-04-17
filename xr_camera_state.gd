extends Node

# Store the XR origin position and rotation
var xr_origin_position: Vector3 = Vector3()
var xr_origin_rotation: Vector3 = Vector3()

# Store the XR camera position relative to origin (for height/orientation)
var xr_camera_local_position: Vector3 = Vector3()
var xr_camera_local_rotation: Vector3 = Vector3()

# Save the current XR camera state
func save_xr_camera_state(xr_origin_node: XROrigin3D) -> void:
	if xr_origin_node:
		# Save origin transform
		xr_origin_position = xr_origin_node.global_position
		xr_origin_rotation = xr_origin_node.global_rotation
		
		# Save camera's relative position to handle user height
		var xr_camera = xr_origin_node.get_node_or_null("XRCamera3D")
		if xr_camera:
			xr_camera_local_position = xr_camera.position
			xr_camera_local_rotation = xr_camera.rotation

# Restore the XR camera state
func restore_xr_camera_state(xr_origin_node: XROrigin3D) -> void:
	if xr_origin_node:
		# Restore origin transform
		xr_origin_node.global_position = xr_origin_position
		xr_origin_node.global_rotation = xr_origin_rotation
		
		# Restore camera's relative position
		var xr_camera = xr_origin_node.get_node_or_null("XRCamera3D")
		if xr_camera:
			xr_camera.position = xr_camera_local_position
			xr_camera.rotation = xr_camera_local_rotation
