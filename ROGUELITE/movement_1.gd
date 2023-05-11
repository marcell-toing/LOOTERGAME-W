extends CharacterBody2D

@export var MAX_SPEED : int = 200

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	# Get the name of the parent node and append "_bounce"
	var current_object_name = self.name
	var active_animation = current_object_name + "_bounce"
	animated_sprite.play(active_animation)

func _process(delta):
	var direction = get_movement_vector().normalized()
	velocity = direction * MAX_SPEED
	move_and_slide()

   
func get_movement_vector():
	var x = Input.get_action_strength("ui_right") - Input.get_action_raw_strength("ui_left")
	var y = Input.get_action_strength("ui_down") - Input.get_action_raw_strength("ui_up")
	return Vector2(x,y)
