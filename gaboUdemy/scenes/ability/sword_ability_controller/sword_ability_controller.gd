extends Node

@export var sword_ability : PackedScene
@export var CHOOSE_SPAWN_POS : String = "enemy" #player or enemy
@export var MAX_RANGE : int = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)



func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	var enemies = get_tree().get_nodes_in_group("enemy") 
	var ability_spawn_pos
	if player == null:
		return
	
	if CHOOSE_SPAWN_POS=="player":
		ability_spawn_pos = player
		
	if CHOOSE_SPAWN_POS=="enemy":
		ability_spawn_pos = enemies.filter(func(enemy : Node2D):
			return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
		)
		if ability_spawn_pos.size()==0:
			return
		else:
			ability_spawn_pos.sort_custom(func(a: Node2D, b: Node2D):
				var a_distance = a.global_position.distance_squared_to(player.global_position)
				var b_distance = b.global_position.distance_squared_to(player.global_position)
				return a_distance < b_distance
			)
	var sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	
	if CHOOSE_SPAWN_POS=="player":
		sword_instance.global_position = ability_spawn_pos.global_position
		
	if CHOOSE_SPAWN_POS=="enemy":
		sword_instance.global_position = ability_spawn_pos[0].global_position
