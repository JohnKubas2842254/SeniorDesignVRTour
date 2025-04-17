extends XROrigin3D

func _ready():
	# Load XR origin state from singleton (if available)
	if CameraState.xr_origin_rotation != Vector3():
		rotation_degrees = CameraState.xr_origin_rotation
	
	if CameraState.xr_origin_position != Vector3():
		global_position = CameraState.xr_origin_position

# Save position after controller movement
func _physics_process(_delta):
	# Update the XR origin state in the singleton
	# Using physics_process ensures we capture changes after controller input is processed
	CameraState.xr_origin_rotation = rotation_degrees
	CameraState.xr_origin_position = global_position
	
# If you need to detect specific controller action that triggers a rotation
func _on_controller_turn_action():
	# Code that handles turning (if implemented separately)
	# Then save state immediately after
	CameraState.xr_origin_rotation = rotation_degrees
