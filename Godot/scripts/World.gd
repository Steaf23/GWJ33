extends Node2D

var show_bag = false

onready var dungeon = $Dungeon
onready var bag = $Bag

func _input(event):
	if event.is_action_pressed("open_bag"):
		show_bag = !show_bag
		toggle_bag(show_bag)
	
func toggle_bag(should_load):
	get_tree().paused = should_load
	Physics2DServer.set_active(true)
		
	dungeon.visible = !should_load
	bag.visible = should_load
	
