extends Node

func _ready():
	randomize()

func play():
	get_child(randi() % get_children().size()).play()
	
func stop():
	for child in get_children():
		child.stop()
