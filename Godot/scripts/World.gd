extends Node2D

enum state {LOOT, BAG, PREPARE, HERO, EVAL, BATTLE, DIALOGUE}

onready var textBox = preload("res://scenes/TextBox.tscn")

var previous_state
var current_state = state.BATTLE
var show_bag = false
var finished_transition = true

onready var dungeon = $Dungeon
onready var bag = $Bag
onready var lootTimer = $LootTimer

func _enter_tree():
	randomize()
	
func _ready():
	bag.connect("hero_died", self, "on_hero_died")
	dungeon.connect("new_room", self, "start_loot")
	current_state = state.DIALOGUE
	var textText = textBox.instance()
	start_loot()

func _process(delta):
	match current_state:
		state.LOOT:
			pass
		state.BAG:
			pass
		state.PREPARE:
			pass
		state.HERO:
			pass
		state.EVAL:
			pass
		state.BATTLE:
			pass
		state.DIALOGUE:
			pass
	
	if lootTimer.time_left < 2:
		dungeon.blink_items()

func start_loot():
	current_state = state.LOOT
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
	
func toggle_bag(should_load, show_hero=false):
	finished_transition = false
	get_tree().paused = should_load
	Physics2DServer.set_active(true)
		
	dungeon.visible = !should_load
	bag.visible = should_load
	bag.camera.current = should_load
	dungeon.player.camera.current = !should_load
	if !should_load:
#		var tween = dungeon.player.camera.zoom_out()
		dungeon.player.in_bag = false
		for item in bag.on_bag_close():
			dungeon.drop_item_from_player(item)
	else:
		dungeon.player.in_bag = true
	finished_transition = true

func open_bag():
	pass
	
func close_bag():
	pass
	
func on_dungeon_request_item_pickup(item):
	if finished_transition:
		if item != null:
			show_bag = true
			var bag_item = ItemConverter.to_bag(item)
			bag.spawn(bag_item)
			item.queue_free()
			toggle_bag(show_bag)
		return

func on_hero_died():
	toggle_bag(false)
	print("THE HERO DIED, AND SO DID YOU >:D")
	get_tree().reload_current_scene()

#func _unhandled_input(event):
#	if event.is_action_pressed("open_bag"):
#		match current_state:
#			state.BAG:
#				close_bag()
#			state.LOOT, state.PREPARE:
#				open_bag()
#			state.HERO:
#				current_state = state.EVAL
#		get_tree().set_input_as_handled()
#
#	if event.is_action_pressed("pickup_item"):
#		match current_state:
#			state.BAG:
#				close_bag()
#			state.LOOT, state.PREPARE:
#				open_bag()
#		get_tree().set_input_as_handled()
