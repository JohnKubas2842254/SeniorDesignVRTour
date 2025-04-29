extends Label3D

@export var panel_margin: float = 40.0  # Adjustable margin in the Inspector

func _ready():
	# Enable text wrapping
	
	# Set width with margin - make this narrower than your visual panel
	width = 260  # Reduced from 300 to provide margin
	
	# Optional: Improve text appearance
	outline_size = 1
	
	# Text sizing and overflow protection
	autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	
	# Better text rendering
	texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	
	# Optional: Set reasonable font size limits if you have variable content length
	font_size = 24  # Adjust this value to your needs
