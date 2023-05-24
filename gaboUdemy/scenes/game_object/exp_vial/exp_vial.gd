extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(on_area_entered) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_area_entered(other_area: Area2D):
	queue_free()
