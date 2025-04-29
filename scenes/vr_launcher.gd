extends Node

func _ready():
    # If we're in the editor and running a different scene directly, don't redirect
    if OS.has_feature("editor") and get_tree().current_scene != self:
        print("Direct scene testing detected - not redirecting")
        return
        
    # Wait a moment to let XR systems initialize
    await get_tree().create_timer(0.2).timeout
    
    # Check if VR is available
    var xr_interface = XRServer.find_interface("OpenXR")
    
    if xr_interface and xr_interface.is_initialized():
        print("VR headset detected - launching VR room")
        get_tree().change_scene_to_file("res://scenes/VR_Room.tscn")
    else:
        print("No VR detected - launching desktop menu")
        get_tree().change_scene_to_file("res://MainMenu.tscn")