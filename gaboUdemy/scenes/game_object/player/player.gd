extends CharacterBody2D

@export var MAX_SPEED : int = 125
@export var ACCELERATION_SMOOTHING : int = MAX_SPEED/10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_movement_vector().normalized()
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta*ACCELERATION_SMOOTHING)) 
	move_and_slide()
	
	
func get_movement_vector():
	var x = Input.get_action_strength("move_right") - Input.get_action_raw_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_raw_strength("move_up")
	return Vector2(x,y)
