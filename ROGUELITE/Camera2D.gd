extends Camera2D

var player_node = Node2D

func _ready():
	# Get the parent node (i.e. the player node) and store it in player_node
	player_node = get_parent()

func _process(delta: float):
	# Check if player_node exists and has a global position
	if player_node and player_node.global_position:
		# Set the camera's global position to the player's global position
		set_global_position(player_node.global_position)
