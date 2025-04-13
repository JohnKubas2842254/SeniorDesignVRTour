extends Area3D

@export var next_scene_path: String  # Set in Inspector, theres an empty "next scene field" to be filled
var input_disabled: bool = false  # Declare the variable properly

func _input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if next_scene_path and next_scene_path != "":
			if input_disabled:
				return  # Prevent double input
			input_disabled = true  # Block further input
			print("Switching to:", next_scene_path)  # Debugging output
			
			# Delegate scene transition to the main script
			var main_node = get_tree().root.get_node("main")  # Adjust if the main node is named differently
			if main_node and main_node.has_method("transition_to_scene"):
				main_node.transition_to_scene(next_scene_path)
			else:
				print("Error: Main node or 'transition_to_scene' method not found!")
		else:
			print("Not a valid transition")
