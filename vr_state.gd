extends Node

# Singleton to track VR state
var is_vr_enabled: bool = false

# Function to initialize and enable VR
func initialize_vr():
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface:
		if xr_interface.is_initialized():
			print("OpenXR initialized. Enabling VR...")
			get_viewport().use_xr = true
			is_vr_enabled = true
		else:
			print("OpenXR interface is not initialized properly.")
			is_vr_enabled = false
	else:
		print("OpenXR interface not found.")
		is_vr_enabled = false

# Function to disable VR
func disable_vr():
	get_viewport().use_xr = false
	is_vr_enabled = false
