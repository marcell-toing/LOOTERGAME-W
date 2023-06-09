extends CharacterBody2D


#@export makes variables easily editable from the EDITOR
#TBD seems type checking is 100% needed here? but doc doesnt suggest so? confusion
@export_category("OUR SPEED VARS")
@export var MAX_SPEED : int = 1000 
@export var ACCELERATION : int = 2000 
@export var FRICTION : int = 8000 


var direction = Vector2.ZERO
var last_direction = Vector2.RIGHT
var active_animation = "idle0"

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play(active_animation)

func _physics_process(delta):
	move(delta)
	update_animation()

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
		var iso_motion = cartesian_to_isometric(direction * ACCELERATION * delta)
		apply_movement(iso_motion)
		last_direction = direction
		
	move_and_slide()

func update_animation():
	if direction == Vector2.ZERO:
		active_animation = "idle"
	else:
		active_animation = "run"
	var animationDir = wrapi(int(last_direction.angle() / (PI/4)), 0, 8)
	animated_sprite.play(active_animation + str(animationDir))
