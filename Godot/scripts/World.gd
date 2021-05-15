extends Node2D

var show_bag = false

onready var dungeon = $Dungeon
onready var bag = $Bag
onready var lootTimer = $LootTimer

func _ready():
	lootTimer.start()

func _unhandled_input(event):
	if event.is_action_pressed("open_bag"):
		show_bag = !show_bag
		toggle_bag(show_bag)
	if event.is_action_pressed("pickup_item"):
		if show_bag:
			show_bag = false
			toggle_bag(show_bag)
			get_tree().set_input_as_handled()
	
func toggle_bag(should_load):
	get_tree().paused = should_load
	Physics2DServer.set_active(true)
		
	dungeon.visible = !should_load
	bag.visible = should_load
	
func on_dungeon_request_item_pickup(item):
	show_bag = true
	var bag_item = item.get_bag_item()
	bag_item.position += Vector2(96, 128)
	bag.add_child(bag_item)
	item.queue_free()
	toggle_bag(show_bag)

func _process(delta):
	if lootTimer.time_left < 2:
		dungeon.blink_items()
