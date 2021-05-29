extends Node

enum State {LOOT, BAG, OTHER}

onready var textBox = preload("res://scenes/TextBox.tscn")

var previous_state
var current_state = State.LOOT setget set_state
var show_bag = false

var first_time = true

onready var dungeon = $Dungeon
onready var player = $Dungeon/YSort/Player
onready var bagLayer = $BagLayer
onready var bag = $BagLayer/Bag
onready var lootTimer = $LootTimer
onready var dialogueLayer = $DialogueLayer
onready var battle_sounds = $MultiSoundContainer

onready var lootingSongA = $LootingA
onready var lootingSongB = $LootingB
onready var lullSongA = $LullA
onready var lullSongB = $LullB

func _enter_tree():
	randomize()
	
func _ready():
	bag.connect("hero_died", self, "on_hero_died")
	dungeon.connect("start_battle", self, "on_dungeon_start_battle")
	dungeon.connect("start_battle_song", self, "on_start_battle_song")
	close_bag()
	lullSongB.play()
	yield(start_dialogue("title"), "completed")
	first_time = true

func _process(delta):
	if lootTimer.time_left < 2:
		dungeon.blink_items()
	
func _unhandled_input(event):
	if event.is_action_pressed("open_bag"):
		match current_state:
			State.BAG:
				set_state(State.LOOT)
				close_bag()
				get_tree().set_input_as_handled()
			State.LOOT:
				set_state(State.BAG)
				open_bag()
				get_tree().set_input_as_handled()
			State.OTHER:
				pass

	if event.is_action_pressed("pickup_item"):
		match current_state:
			State.BAG:
				close_bag()
				get_tree().set_input_as_handled()
			_:
				pass
	
	if event.is_action_pressed("ui_accept"):
		print("Current State: %s" % [State.keys()[current_state]])

func open_bag(show_hero=false):
#	print("Opening bag..")
	bagLayer.add_child(bag)
	if show_hero:
		bag.show_equipment()
	get_tree().paused = true
	Physics2DServer.set_active(true)
	
	player.show_bag = true
#	player.camera.set_new_limits([Vector2(-100000, -100000), Vector2(100000, 100000)])
#	yield(player.camera.zoom_in(), "tween_completed")
	bag.visible = true
	set_state(State.BAG)
	get_tree().paused = true
	
func close_bag():
	print("Closing bag..")
#	if bag.get_parent() == null:
#		print("BAG IS DEAD")
	bag.hide_equipment()
	get_tree().paused = false
	
	bag.visible = false
	
	player.show_bag = false
	dungeon.drop_items_from_player(bag.get_drop_items())
#	yield(player.camera.zoom_out(), "tween_completed")
#	player.camera.set_new_limits(player.camera.prev_limits)
	set_state(State.LOOT)
	bagLayer.remove_child( bag) 
	
	
func on_dungeon_request_item_pickup(item):
	show_bag = true
	if item != null:
		var bag_item = ItemConverter.to_bag(item)
		bag.add(bag_item)
		item.queue_free()
		open_bag()
	else:
		open_bag(true)
	return

func on_hero_died():
	close_bag()
	print("THE HERO DIED, AND SO DID YOU >:D")
	get_tree().reload_current_scene()

func on_dungeon_start_battle():
	set_state(State.OTHER)
	if first_time:
		first_time = false
		yield(start_dialogue("start"), "completed")
#	if lootTimer.time_left > 0:
#		# confirmation dialogue since time isnt up yet yield answer from player?
#		yield(start_dialogue("premature_exit"), "completed")
#		return
	lootTimer.stop()
	dungeon.force_next_room()
	start_loot()

func start_loot():
	battle_sounds.stop()
	set_state(State.LOOT)
	lootTimer.start()
	if randi() % 2 == 0:
		lootingSongA.play()
	else:
		lootingSongB.play()

func start_dialogue(dialogue_name):
	set_state(State.OTHER)
	player.freeze = true
	var test_text = textBox.instance()
	test_text.dialogue = "res://resources/dialogue_" + dialogue_name + ".json"
	dialogueLayer.add_child(test_text)
	yield(test_text, "dialogue_completed")
	player.freeze = false
	set_state(previous_state)
	
func set_state(new_state):
	previous_state = current_state
	current_state = new_state
#	print("Current: %s, Prev: %s " % [State.keys()[current_state], State.keys()[previous_state]])

func on_start_battle_song():
	lullSongA.stop()
	lullSongB.stop()
	battle_sounds.play()

func _on_LootTimer_timeout():
	lootingSongA.stop()
	lootingSongB.stop()
	if randi() % 2 == 0:
		lullSongA.play()
	else:
		lullSongB.play()
