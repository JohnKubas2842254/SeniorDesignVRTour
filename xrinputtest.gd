extends Node

func _input(event):
	if event is InputEventJoypadButton:
		print("Joypad Button Pressed:")
		print("Device:", event.device)
		print("Button Index:", event.button_index)
		print("Pressed:", event.pressed)
	elif event is InputEventJoypadMotion:
		print("Joypad Motion Detected:")
		print("Device:", event.device)
		print("Axis:", event.axis)
		print("Value:", event.axis_value)
