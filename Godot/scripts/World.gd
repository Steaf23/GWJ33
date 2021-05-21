extends Node

enum State {LOOT, BAG, PREPARE, HERO, EVAL, BATTLE, DIALOGUE}

onready var textBox = preload("res://scenes/TextBox.tscn")

var previous_state
var current_state = State.BATTLE setget set_state
var show_bag = false

onready var dungeon = $Dungeon
onready var player = $Dungeon/YSort/Player
onready var bag = $Bag
onready var lootTimer = $LootTimer

func _enter_tree():
	randomize()
	
func _ready():
	bag.connect("hero_died", self, "on_hero_died")
	dungeon.connect("new_room", self, "start_loot")
#	set_state(State.DIALOGUE)
#	var test_text = textBox.instance()
#	add_child(test_text)
	start_loot()

func _process(delta):
	match current_state:
		State.LOOT:
			pass
		State.BAG:
			pass
		State.PREPARE:
			pass
		State.HERO:
			pass
		State.EVAL:
			pass
		State.BATTLE:
			pass
		State.DIALOGUE:
			pass
	
	if lootTimer.time_left < 2:
		dungeon.blink_items()

func start_loot():
	set_state(State.LOOT)
	lootTimer.start()
#
#func _unhandled_input(event):
#	if event.is_action_pressed("open_bag"):
#		show_bag = !show_bag
#		toggle_bag(show_bag)
#	if event.is_action_pressed("pickup_item"):
#		if show_bag:
#			show_bag = false
#			toggle_bag(show_bag)
#			get_tree().set_input_as_handled()
	
func _unhandled_input(event):
	if event.is_action_pressed("open_bag"):
		match current_state:
			State.BAG:
				close_bag()
			State.LOOT, State.PREPARE:
				open_bag()
			State.HERO:
				close_bag()
				set_state(State.EVAL)

	if event.is_action_pressed("pickup_item"):
		match current_state:
			State.BAG:
				close_bag()
				get_tree().set_input_as_handled()
			State.HERO:
				close_bag()
				set_state(State.EVAL)
				get_tree().set_input_as_handled()

#func toggle_bag(should_load, show_hero=false):
#	get_tree().paused = should_load
#	Physics2DServer.set_active(true)
#
#	dungeon.visible = !should_load
#	bag.visible = should_load
#	bag.camera.current = should_load
#	dungeon.player.camera.current = !should_load
#	if !should_load:
##		var tween = dungeon.player.camera.zoom_out()
#		dungeon.player.show_bag = false
#		dungeon.drop_items_from_player(bag.on_bag_close())
#	else:
#		dungeon.player.show_bag = true

func open_bag(show_hero=false):
	if show_hero:
		bag.show_equipment()
	get_tree().paused = true
	Physics2DServer.set_active(true)
	
	dungeon.visible = false
	bag.visible = true
	player.camera.current = false
	bag.camera.current = true
	player.show_bag = true
	set_state(State.BAG if !show_hero else State.HERO)
	
func close_bag():
	bag.hide_equipment()
	get_tree().paused = false
	
	dungeon.visible = true
	bag.visible = false
	bag.camera.current = false
	player.camera.current = true
	
	player.show_bag = false
	dungeon.drop_items_from_player(bag.close())
	set_state(previous_state)
	
func on_dungeon_request_item_pickup(item):
	show_bag = true
	if item != null:
		var bag_item = ItemConverter.to_bag(item)
		bag.spawn(bag_item)
		item.queue_free()
		open_bag()
	else:
		open_bag(true)
	return

func on_hero_died():
	close_bag()
	print("THE HERO DIED, AND SO DID YOU >:D")
	get_tree().reload_current_scene()

func set_state(new_state):
	previous_state = current_state
	current_state = new_state
	print("SET STATE, NEW: %s, OLD: %s" % 
		[State.keys()[current_state], State.keys()[previous_state]])
