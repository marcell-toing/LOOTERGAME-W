extends KinematicBody2D

export (int) var speed = 55

var velocity = Vector2()

var direction = "move_right"


func _process(_delta):
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

	if Input.is_action_just_pressed("move_right"):
		$AnimatedSprite.set_flip_h(false)
		direction = "move_right"
	elif Input.is_action_just_pressed("move_left"):
		$AnimatedSprite.set_flip_h(true)
		direction = "move_left"

	velocity = move_and_slide(velocity)
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		

