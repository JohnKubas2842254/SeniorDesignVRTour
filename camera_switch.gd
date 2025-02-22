extends Node

@export var vr_camera : Camera3D
@export var normal_camera : Camera3D
var is_vr_enabled : bool = false

func _ready():
	# Check if VR device is connected when the game starts
	check_vr_status()

func check_vr_status():
	# Get list of connected XR devices
	var devices = XRServer.get_devices()
	
	# If a VR device is found, enable VR
	if devices.size() > 0:
		enable_vr()
	else:
		enable_non_vr()

# Enable VR functionality
func enable_vr():
	is_vr_enabled = true
	vr_camera.current = true  # Set VR camera to be active
	normal_camera.current = false  # Set normal camera to be inactive

	# Assuming you are using XRInterface for VR rendering
	var xr_interface = XRServer.get_interface("OpenXR")  # Or your specific VR interface
	if xr_interface:
		xr_interface.set_primary_camera(vr_camera)

# Enable non-VR functionality
func enable_non_vr():
	is_vr_enabled = false
	vr_camera.current = false  # Set VR camera to be inactive
	normal_camera.current = true  # Set normal camera to be active

	# You can use the regular camera here
	var xr_interface = XRServer.get_interface("OpenXR")  # Or your specific VR interface
	if xr_interface:
		xr_interface.set_primary_camera(normal_camera)
