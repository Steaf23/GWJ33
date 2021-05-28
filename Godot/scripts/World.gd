extends Node

enum State {LOOT, BAG, PREPARE, HERO, EVAL, BATTLE, DIALOGUE}

onready var textBox = preload("res://scenes/TextBox.tscn")

var previous_state
var current_state = State.LOOT setget set_state
var show_bag = false

var first_time = true

onready var dungeon = $Dungeon
onready var player = $Dungeon/YSort/Player
onready var bag = $BagLayer/Bag
onready var lootTimer = $LootTimer
onready var dialogueLayer = $DialogueLayer
onready var battle_sounds = $MultiSoundContainer

onready var A = $LootingA
onready var B = $LootingB
onready var Al = $LullA
onready var Bl = $LullB

func _enter_tree():
	randomize()
	
func _ready():
	bag.connect("hero_died", self, "on_hero_died")
	dungeon.connect("start_battle", self, "on_dungeon_start_battle")
	dungeon.connect("start_battle_song", self, "on_start_battle_song")
	bag.hide_equipment()
	Bl.play()
	yield(start_dialogue("title"), "completed")
	first_time = true

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
	
	if event.is_action_pressed("ui_accept"):
		print("Current State: %s" % [State.keys()[current_state]])

func open_bag(show_hero=false):
	if show_hero:
		bag.show_equipment()
	Physics2DServer.set_active(true)
	
	player.show_bag = true
#	player.camera.set_new_limits([Vector2(-100000, -100000), Vector2(100000, 100000)])
#	yield(player.camera.zoom_in(), "tween_completed")
	bag.visible = true
	
	get_tree().paused = true
	set_state(State.BAG)
	
func close_bag():
	bag.hide_equipment()
	get_tree().paused = false
	
	bag.visible = false
	
	player.show_bag = false
	dungeon.drop_items_from_player(bag.close())
#	yield(player.camera.zoom_out(), "tween_completed")
#	player.camera.set_new_limits(player.camera.prev_limits)
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

func on_dungeon_start_battle():
	set_state(State.HERO)
	if first_time:
		first_time = false
		yield(start_dialogue("start"), "completed")
#	if lootTimer.time_left > 0:
#		# confirmation dialogue since time isnt up yet yield answer from player?
#		yield(start_dialogue("premature_exit"), "completed")
#		return
	lootTimer.stop()
	yield(dungeon.force_next_room(), "completed")
	start_loot()

func start_loot():
	set_state(State.LOOT)
	lootTimer.start()
	if randi() % 2 == 0:
		A.play()
	else:
		B.play()

func start_dialogue(dialogue_name):
	set_state(State.DIALOGUE)
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

func on_start_battle_song():
	Al.stop()
	Bl.stop()
	print("PLAY")
	battle_sounds.play()

func _on_LootTimer_timeout():
	A.stop()
	B.stop()
	if randi() % 2 == 0:
		Al.play()
	else:
		Bl.play()
