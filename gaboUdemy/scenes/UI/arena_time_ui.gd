extends CanvasLayer

@export var arena_time_manager : Node
@onready var label = $%ArenaTime

func _process(_delta):
	if arena_time_manager == null:
		return
	var time_elapsed = arena_time_manager.get_time_elapsed()
	var minutes = format_seconds(time_elapsed)["minutes"]
	var leftover_seconds = format_seconds(time_elapsed)["seconds"]
	label.text =  str(minutes) + ":" + str("%02d" % leftover_seconds)
	
func format_seconds(seconds: float):
	var minutes = floor(seconds/60)
	var leftover_seconds = floor(seconds - (minutes*60))
	return {"minutes": minutes, 
			"seconds":leftover_seconds}
