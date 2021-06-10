extends Node

enum State {LOOT, BAG, OTHER}

onready var textBox = preload("res://scenes/TextBox.tscn")

var previous_state
var current_state = State.LOOT setget set_state

var first_time = true
var zooming = false
var victory = true

onready var dungeon = $DungeonLayer/Dungeon
onready var player = $DungeonLayer/Dungeon/YSort/Player
onready var bagLayer = $BagLayer
onready var bag = $BagLayer/Bag
onready var lootTimer = $LootTimer
onready var dialogueLayer = $DialogueLayer
onready var battle_sounds = $BattleMusic

onready var lootingMusic = $LootingMusicPlayer
onready var lullSongA = $LullA
onready var lullSongB = $LullB

func _enter_tree():
	randomize()
	
func _ready():
	Score.room_score = 0
#	bag.connect("hero_died", self, "on_hero_died")
	bag.connect("close", self, "on_bag_closed")
#	dungeon.connect("start_battle", self, "on_dungeon_start_battle")
	dungeon.connect("start_battle_song", self, "on_start_battle_song")
	on_bag_closed()
	lullSongB.play()
	yield(start_dialogue("title"), "completed")
	first_time = true

func _process(delta):
	Score.room_time = int(lootTimer.time_left)
	if lootTimer.time_left < 2:
		dungeon.blink_items()
	
func _unhandled_input(event):
	if !zooming:
		if event.is_action_pressed("Open bag"):
			match current_state:
				State.LOOT:
					open_bag()
					get_tree().set_input_as_handled()

		if event.is_action_pressed("Interact"):
			match current_state:
				State.LOOT:
					if !check_for_item():
						if dungeon.hero.get_player() != null:
							start_battle()
	
		if event.is_action_pressed("ui_accept"):
			print("Current State: %s" % [State.keys()[current_state]])

func check_for_item():
	var items = dungeon.get_colliding_items()
	if items.size() > 0:
		set_state(State.BAG)
		var item_id = items[0].id
		items[0].queue_free()
		open_bag(false, true, item_id)
		return true
	else:
		return false

func open_bag(show_hero=false, show_success=true, item_id: String = ""):
	if show_hero:
		bag.show_equipment(show_success)
	
	if item_id != "":
		bag.add(item_id)

	player.show_bag = true
	
#	zooming = true
#	player.camera.set_new_limits([Vector2(-100000, -100000), Vector2(100000, 100000)])
#	yield(player.camera.zoom_in(), "tween_completed")
#	zooming = false
	
	bag.visible = true
	set_state(State.BAG)
	bag.is_open = true
	
func on_bag_closed(items=[]):
	bag.is_open = false
	bag.hide_equipment()
	bag.visible = false
	dungeon.drop_items_from_player(items)
	player.show_bag = false
	
#	zooming = true
#	yield(player.camera.zoom_out(), "tween_completed")
#	player.camera.set_new_limits(dungeon.current_room.get_limits())
#	zooming = false
	
	set_state(State.LOOT)
	
func on_dungeon_request_item_pickup(item):
	if item != null:
		bag.add(item.id)
		item.queue_free()
		open_bag()
	else:
		open_bag(true)
	return

func on_hero_died():
	on_bag_closed()
	print("THE HERO DIED, AND SO DID YOU >:D")
	get_tree().reload_current_scene()

func start_battle():
	set_state(State.OTHER)
	if first_time:
		yield(start_dialogue("start"), "completed")
		open_bag(true, false)
		yield(bag, "close")
		yield(start_dialogue("start2"), "completed")
	else:
#		if lootTimer.time_left > 0:
#			# confirmation dialogue since time isnt up yet yield answer from player?
#			yield(start_dialogue("premature_exit"), "completed")
#			return
		open_bag(true)
		yield(bag, "close")
	if randi() % 100 <= bag.heroEquipment.evaluate_equipment() + 10 or first_time:
		victory = true
		pass
	else:
		bag.set_hp(bag.current_hp - 1)
		victory = false
			
	lootTimer.stop()
	dungeon.blink = false
	yield(dungeon.force_next_room(), "completed")
	if bag.current_hp <= 0:
			game_over()
		
	if first_time:
		first_time = false
	start_loot()

func start_loot():
	battle_sounds.stop()
	set_state(State.LOOT)
	lootTimer.start()
	dungeon.blink = true
	lootingMusic.play()

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
	lootingMusic.stop()
	lullSongA.stop()
	lullSongB.stop()
	battle_sounds.play(victory)

func _on_LootTimer_timeout():
	lootingMusic.stop()
	if randi() % 2 == 0:
		lullSongA.play()
	else:
		lullSongB.play()

func game_over():
	get_tree().change_scene("res://scenes/GameOverScreen.tscn")
