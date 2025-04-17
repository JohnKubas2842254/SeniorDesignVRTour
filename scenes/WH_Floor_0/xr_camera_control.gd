extends XRCamera3D

@export var rotation_speed := 0.005  # If you need manual rotation control for testing

func _ready():
	# Load XR camera state from singleton (if available)
	if CameraState.xr_camera_rotation != Vector3():
		rotation_degrees = CameraState.xr_camera_rotation
	
	if CameraState.xr_camera_position != Vector3():
		global_position = CameraState.xr_camera_position

# For VR, you typically want to update the state continuously since head movement happens all the time
func _process(_delta):
	# Update the XR camera state in the singleton
	CameraState.xr_camera_rotation = rotation_degrees
	CameraState.xr_camera_position = global_position

# Optional: If you need manual control for testing or non-VR mode
func _input(event):
	# Handle any manual camera control if needed
	# This would be similar to your camera_control.gd input handling
	pass
