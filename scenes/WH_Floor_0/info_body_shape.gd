extends Area3D

# Reference to your text panel (assign this in the Inspector)
@export var info_panel: Node3D

var input_disabled: bool = false

func _ready():
	# Make sure the panel starts hidden
	if info_panel:
		info_panel.visible = false

# Handle mouse click in desktop mode
func _input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		display_information()

# Handle VR laser pointer events
func pointer_event(event: XRToolsPointerEvent) -> void:
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		display_information()

# This is the method that will be called by the VR pointer
func display_information():
	if input_disabled:
		return  # Prevent spam clicking
	
	# Toggle the visibility of the information panel
	if info_panel:
		info_panel.visible = !info_panel.visible
		
		# If showing the panel, make sure it's properly positioned and oriented
		if info_panel.visible:
			# Start animation
			info_panel.scale = Vector3(0.1, 0.1, 0.1)
			var tween = create_tween()
			tween.tween_property(info_panel, "scale", Vector3(1, 1, 1), 0.3)
			
			# Make sure panel is properly positioned relative to the camera
			_update_panel_position()
	
	# Brief input lock
	input_disabled = true
	get_tree().create_timer(0.3).timeout.connect(func(): input_disabled = false)

# Update panel orientation every frame when visible
func _process(_delta):
	# If panel is visible, make sure it stays properly oriented
	if info_panel and info_panel.visible:
		_update_panel_position()

# Function to make the panel face the camera
func _update_panel_position():
	# Get the camera
	var camera = get_viewport().get_camera_3d()
	if camera:
		# Make the panel face the camera
		var look_at_pos = camera.global_transform.origin
		
		# Only rotate around Y-axis (keeps panel upright)
		var dir = look_at_pos - info_panel.global_transform.origin
		dir.y = 0  # Zero out y component to only rotate on y-axis
		
		if dir.length() > 0.001:
			# Look at camera position but only on Y axis
			info_panel.look_at(info_panel.global_transform.origin + dir, Vector3.UP)
