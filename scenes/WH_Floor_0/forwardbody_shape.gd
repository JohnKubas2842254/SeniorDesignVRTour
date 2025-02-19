extends Area3D  # Make sure this is at the top!

@export var next_scene_path: String  # Set in Inspector, theres an empty "next scene field" to be filled
var input_disabled: bool = false  # Declare the variable properly

func _input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if next_scene_path and next_scene_path != "":
			input_disabled = true  # Block further input
			print("Switching to:", next_scene_path)  # Debugging output
			get_tree().change_scene_to_file(next_scene_path)
		else:
			print("Not a valid transition")
