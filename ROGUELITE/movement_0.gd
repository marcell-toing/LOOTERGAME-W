extends CharacterBody2D

@export var speed = 85.0

var direction = Vector2.ZERO
var last_direction = Vector2.RIGHT

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	# Get the name of the parent node and append "_bounce"
	var current_object_name = self.name
	var active_animation = current_object_name + "_bounce"
	animated_sprite.play(active_animation)

func _process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed*delta
		velocity.y = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed*delta
		velocity.y = 0
	if Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y -= speed*delta
	if Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y += speed*delta
		
	move_and_slide()
