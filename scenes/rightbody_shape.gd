extends Area3D

@export var next_scene_path: String  # Set in Inspector, theres an empty "next scene field" to be filled
var input_disabled: bool = false  # Declare the variable properly

# Called when the player clicks on the marker
func _input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		handle_scene_transition()

# NEW: Called when a laser pointer interacts with the marker
func _on_marker_body_entered(body):
	if body.name.contains("Pointer") and not input_disabled:
		input_disabled = true  # Block further input to prevent multiple triggers
		print("Switching scene to:", next_scene_path)  # Debugging output
		if next_scene_path and next_scene_path != "":
			get_tree().change_scene_to_file(next_scene_path)
		else:
			print("No valid next_scene_path set for marker:", name)

# Function to handle transitioning to the next scene
func handle_scene_transition():
	if input_disabled:
		return  # Prevent multiple inputs
	if next_scene_path and next_scene_path != "":
		input_disabled = true
		print("Switching to:", next_scene_path)
		# Call the transition function in the main script
		var main_node = get_tree().root.get_node("main")  # Adjust if named differently
		if main_node and main_node.has_method("transition_to_scene"):
			main_node.transition_to_scene(next_scene_path)
		else:
			# Fallback direct scene change if main node not found
			get_tree().change_scene_to_file(next_scene_path)
	else:
		print("Not a valid transition")

# NEW: Called from signal when pointer trigger is pressed while pointing at this object
func external_transition_trigger():
	handle_scene_transition()
