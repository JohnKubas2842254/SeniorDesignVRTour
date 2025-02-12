extends Node3D

func _ready():
	print("Scene loaded:", get_tree().current_scene.name)

func transition_to_scene(scene_path: String):
	if scene_path:
		get_tree().change_scene_to_file(scene_path)
