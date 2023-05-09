extends CharacterBody2D


#@export makes variables easily editable from the EDITOR
#TBD seems type checking is 100% needed here? but doc doesnt suggest so? confusion
@export_category("OUR SPEED VARS")
@export var MAX_SPEED : int = 160 
@export var  ACCELERATION : int = 1500 
@export var  FRICTION : int = 1200 


var curent_animation = "idle" # TBD implement animations
var axis = Vector2.ZERO

func _physics_process(delta):
	move(delta)

#tbd should we wrap Input with int()?
func get_input_axis():
	axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	axis.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return axis.normalized()
	
	
func move(delta):
	axis = get_input_axis()

	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
		
	else:
		apply_movement(axis * ACCELERATION * delta) 

	move_and_slide()	


func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO


func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)