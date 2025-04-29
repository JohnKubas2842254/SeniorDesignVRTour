extends Area3D

# Normal and hover materials
var normal_material: Material
var hover_material: Material
var marker_mesh: MeshInstance3D

# Reference to the light
var marker_light: OmniLight3D
var normal_light_energy = 2.0
var hover_light_energy = 10.0  # Increased further for maximum impact

# Track hover state
var is_hovered = false

# Dark green color for stronger contrast
var hover_color = Color(0.0, 0.3, 0.1, 1.0)  # Rich dark green

func _ready():
	# Connect signals for desktop mode
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	# Get the mesh reference
	marker_mesh = get_parent()
	
	# Store the normal material
	normal_material = marker_mesh.material_override.duplicate()
	
	# Create hover material based on normal material with enhanced dark green glow
	hover_material = normal_material.duplicate()
	hover_material.emission_enabled = true
	hover_material.emission = hover_color  # Dark green
	hover_material.emission_energy_multiplier = 5.0  # Even higher energy for maximum visibility
	
	# Get the associated light
	var light_name = marker_mesh.name.replace(" marker", "MarkerOmniLight3D")
	marker_light = marker_mesh.get_parent().get_node_or_null(light_name)
	
	# Change light color to match hover color if found
	if marker_light:
		marker_light.light_color = hover_color  # Same dark green

func _physics_process(_delta):
	# For VR laser pointer detection
	if Global.vr_enabled:
		var has_hover = false
		
		# Check for active pointers intersecting
		for body in get_overlapping_bodies():
			if body.name == "FunctionPointer" or body.name == "LeftHandController" or body.name == "RightHandController":
				has_hover = true
				break
		
		# Update hover state
		set_hovered(has_hover)

func _on_mouse_entered():
	if not Global.vr_enabled:
		set_hovered(true)

func _on_mouse_exited():
	if not Global.vr_enabled:
		set_hovered(false)

func set_hovered(hovered: bool):
	if hovered == is_hovered:
		return
		
	is_hovered = hovered
	
	if is_hovered:
		# Apply hover material
		marker_mesh.material_override = hover_material
		# Increase light intensity
		if marker_light:
			marker_light.light_energy = hover_light_energy
			# Make the light pulse with more pronounced effect
			var tween = create_tween()
			tween.tween_property(marker_light, "light_energy", hover_light_energy + 4.0, 0.5)
			tween.tween_property(marker_light, "light_energy", hover_light_energy, 0.5)
			tween.set_loops()
	else:
		# Restore normal material
		marker_mesh.material_override = normal_material
		# Restore normal light intensity
		if marker_light:
			# Stop any active tweens
			var tweens = get_tree().get_root().find_children("*", "Tween", true, false)
			for t in tweens:
				if t.is_valid() and t.has_meta("target") and t.get_meta("target") == marker_light:
					t.kill()
			marker_light.light_energy = normal_light_energy
