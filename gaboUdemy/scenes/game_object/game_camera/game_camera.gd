extends Camera2D

var target_position = Vector2.ZERO
var ACCELERATION_SMOOTHING = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current() # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta*ACCELERATION_SMOOTHING))

func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position	
