extends Area3D

@export var next_scene_path: String  # Set in Inspector, path to the next scene
var input_disabled: bool = false  # Prevents multiple triggers

# Signal for debugging or effects (optional)
signal marker_activated(next_scene)

func _ready():
	# Ensure the Area3D is set up for monitoring
	monitoring = true
	monitorable = true
	# Connect the area_entered signal if not already connected in the editor
	if not is_connected("area_entered", _on_area_entered):
		connect("area_entered", _on_area_entered)

func _input_event(_camera, event, _position, _normal, _shape_idx):
	# Handle mouse input for 3D mode
	if not XRServer.primary_interface:  # Non-VR mode
		if event is InputEventMouseButton and event.pressed and not input_disabled:
			_activate_marker()

func _on_area_entered(area: Area3D):
	# Handle VR controller laser collision
	if XRServer.primary_interface and not input_disabled:  # VR mode active
		var controller = area.get_parent()
		if controller is XRController3D:
			# Check if the trigger is pressed
			if controller.get_float("trigger") > 0.5:  # Using get_float for analog trigger
				_activate_marker()

func _activate_marker():
	# Common function to handle scene transition
	if next_scene_path and next_scene_path != "":
		input_disabled = true
		print("Switching to:", next_scene_path)
		emit_signal("marker_activated", next_scene_path)
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("Not a valid transition")

# Optional: Reset input_disabled if needed
func _reset_input():
	input_disabled = false
