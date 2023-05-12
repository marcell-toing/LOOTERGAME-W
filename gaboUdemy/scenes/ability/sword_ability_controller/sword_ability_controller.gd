extends Node

@export var sword_ability : PackedScene
@export var SPAWN_ON_PLAYER : bool = true  #player or enemy
@export var MAX_RANGE : int = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	var closest_enemy_position = get_closest_enemy()
	if player == null or closest_enemy_position==Vector2.ZERO:
		return
			
	var sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance) # DO THIS ASAP? IF DONE AT END, ANIM HAPPENS W/O EFFECT
	
	var spawn_pos_offset = + Vector2.RIGHT.rotated(randf_range(0, TAU))*4 	
	var direction_to_closest_enemy = closest_enemy_position - sword_instance.global_position
	sword_instance.rotation = direction_to_closest_enemy.angle()
	
	if SPAWN_ON_PLAYER:
		sword_instance.global_position = player.global_position + spawn_pos_offset
	else:
		sword_instance.global_position = closest_enemy_position + spawn_pos_offset
	
	
	
func get_closest_enemy():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy") 
	var enemies_position = enemies.filter(func(enemy : Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2))
		
	if enemies_position.size()==0:
		return Vector2.ZERO
	else:
		enemies_position.sort_custom(func(a: Node2D, b: Node2D):
				var a_distance = a.global_position.distance_squared_to(player.global_position)
				var b_distance = b.global_position.distance_squared_to(player.global_position)
				return a_distance < b_distance
				)
		return enemies_position[0].global_position
