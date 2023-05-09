extends CharacterBody2D


#@export makes variables easily editable from the EDITOR
#TBD seems type checking is 100% needed here? but doc doesnt suggest so? confusion
@export_category("OUR SPEED VARS")
@export var MAX_SPEED : int = 160 
@export var  ACCELERATION : int = 1500 
@export var  FRICTION : int = 1200 


var current_animation = "idle" # TBD implement animations
var direction = Vector2.ZERO
var a = 3

func _physics_process(delta):
	move(delta)


func cartesian_to_isometric(vector):
	return Vector2(vector.x - vector.y, (vector.x + vector.y) / 2)
	
func get_input_direction(): #tbd should we wrap Input with int()?
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return direction.normalized()
	

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO


func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)


func move(delta):
	direction = get_input_direction()

	if direction == Vector2.ZERO:
		var motion = FRICTION * delta
		apply_friction(motion)
		
	else:
		var motion = direction * ACCELERATION * delta
		var iso_motion = cartesian_to_isometric(motion)
		apply_movement(iso_motion)

	move_and_slide()

	func _process(delta):
		current_animation = "idle"
		var input_dir = Vector2.ZERO
		if Input.is_action_pressed("right"):
			input_dir.x += 1
		if Input.is_action_pressed("left"):
			input_dir.x -= 1
		if Input.is_action_pressed("down"):
			input_dir.y += 1
		if Input.is_action_pressed("up"):
			input_dir.y -= 1
		input_dir = input_dir.normalized()
		if input_dir.length() != 0:
			a = input_dir.angle() / (PI/4)
			a = wrapi(int(a), 0, 8)
			current_animation = "run"
	
		$AnimatedSprite.animation = current_animation + str(a)