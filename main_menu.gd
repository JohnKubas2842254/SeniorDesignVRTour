extends Control  # This depends on the type of your root node (e.g., Panel, VBoxContainer)

func _ready():
	# Connect buttons to the functions
	$VBoxContainer/Button.pressed.connect(_on_Button_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_Button2_pressed)
	$VBoxContainer/Button3.pressed.connect(_on_Button3_pressed)
	$VBoxContainer/Button4.pressed.connect(_on_Button4_pressed)
	$VBoxContainer/Button5.pressed.connect(_on_Button5_pressed)

# Function to change to Scene 1 when Button1 is pressed
func _on_Button_pressed():
	get_tree().change_scene_to_file("res://scenes/WH_Floor_1/WH_1_1.tscn")

# Function to change to Scene 2 when Button2 is pressed
func _on_Button2_pressed():
	var scene = load("res://Scene2.tscn")
	get_tree().change_scene_to_file(scene)

# Function to change to Scene 3 when Button3 is pressed
func _on_Button3_pressed():
	var scene = load("res://Scene3.tscn")
	get_tree().change_scene_to_file(scene)

# Similarly, add functions for the other buttons
func _on_Button4_pressed():
	var scene = load("res://Scene4.tscn")
	get_tree().change_scene_to_file(scene)

func _on_Button5_pressed():
	var scene = load("res://Scene5.tscn")
	get_tree().change_scene_to_file(scene)

func _on_Button6_pressed():
	var scene = load("res://Scene6.tscn")
	get_tree().change_scene_to_file(scene)
