extends Node2D

const FLOOR_TILES = [0, 2, 3]
const UNIQUE_ROOM_COUNT = 2
const ROOM_DISTANCE = 64

#signal request_item_pickup(item)
#signal start_battle()
signal start_battle_song()

var time_up = false

onready var player = $YSort/Player
onready var hero = $YSort/Hero
onready var objectList = $YSort
onready var preload_rooms = []
onready var current_room
onready var current_corpse = ""

func _ready():
	fill_room_list()
	setup_start_room()
	player.position = current_room.door_exit + Vector2(16, 0)

func _process(delta):
	current_room.apply_slope_transform(player)

func fill_room_list():
	for i in range(UNIQUE_ROOM_COUNT):
		preload_rooms.append(load("res://scenes/rooms/Room" + str(i) + ".tscn"))

func instance_random_room():
	var room_id = randi() % UNIQUE_ROOM_COUNT
	var warning = ItemLookup.WARNING_TYPES[randi() % ItemLookup.WARNING_TYPES.size()]
	print("Picking Room %d as next room, with as warning %s" % [room_id, warning])
	var new_room = preload_rooms[room_id].instance()
	new_room.id = room_id
	new_room.warning = warning
	return new_room

func force_next_room():
	hero.collision.disabled = true
	# prevent the same room to be generated twice in a row
	var tween = player.move_to(Vector2(current_room.door_entrance.x + 16, player.position.y), .5)
	yield(tween, "tween_completed")
	hero.visible = false

	# duration should be 10 for battle sequence
	tween = player.move_to(player.position, 2)
	# ADD BATTLE MUSIC STUFF HERE
	emit_signal("start_battle_song")
	yield(tween, "tween_completed")
	
	current_corpse = current_room.warning
	
	current_room.open_door()
	var new_room = instance_random_room()
	while new_room.id == current_room.id:
		new_room = instance_random_room()
	setup_room(new_room)
	hero.visible = true
	current_room.open_door()
	tween = player.move_to(Vector2(player.position.x, current_room.door_exit.y), 1)
	yield(tween, "tween_completed")
	player.position = current_room.door_exit + Vector2(16, 0)
	current_room.close_door()
	Score.room_score += 1
	print("total rooms: %d" % Score.room_score)

func setup_start_room():
	var starting_room = load("res://scenes/rooms/RoomStart.tscn").instance()
	objectList.add_child(starting_room)
	
	starting_room.position = Vector2(0, 0)
	starting_room.set_room_extents()
	starting_room.warning = "imp"
	
	player.camera.set_new_limits(starting_room.limits)
	hero.position = starting_room.door_entrance + Vector2(16, 0)
	current_room = starting_room
	return starting_room

func setup_room(new_room):
	objectList.add_child(new_room)
	
	new_room.position = current_room.door_entrance - new_room.door_exit - Vector2(0, 32)
	new_room.position.y = new_room.position.y - 32 - ROOM_DISTANCE
#		current_room.queue_free()
	new_room.set_room_extents()
	
	player.camera.set_new_limits(new_room.limits)
	hero.position = new_room.door_entrance + Vector2(16, 0)
	hero.collision.disabled = false
	current_room = new_room
	place_corpses()
	generate_items(10)
	return new_room

func get_colliding_items():
	var colliding_items = []
	for item in get_items():
		if item.get_player() != null:
			colliding_items.append(item)
	return colliding_items
		
func generate_items(percentage):
	if percentage >= 100:
		percentage = 99
	var amount = current_room.get_max_amount_items(percentage)
	var ground_tiles = current_room.specialLayer.get_item_tiles()
	
	for tile in ground_tiles:
		if current_room.to_global(tile) == current_room.room_world_to_map(hero.position):
			ground_tiles.erase(tile)
	
	ground_tiles.shuffle()
	var selected_tiles = ground_tiles.slice(0, amount)
	
	print("Generating %d items" % selected_tiles.size())
	for tile in selected_tiles:
		var item = ItemConverter.create_ground_item(ItemLookup.get_random_item_name())
		var offset = Vector2(randi() % 16 + 8, randi() % 16  + 8)
		
		item.position = current_room.room_map_to_world(tile) + offset
		objectList.add_child(item)
		
func place_corpses():
	randomize()
	var tiles = current_room.specialLayer.get_corpse_tiles()
	tiles.shuffle()
	tiles = tiles.slice(0, max(tiles.size() - (randi() % 6), 1))
	for tile in tiles:
		var c = Sprite.new()
		objectList.add_child(c)
		c.position = current_room.room_map_to_world(tile) + Vector2(16, 16)
		c.texture = load("res://assets/sprites/corpse_" + current_corpse + ".png")
		c.z_as_relative = false
		c.z_index = 70
		
func drop_items_from_player(items: Array):
	for item in items:
		drop_item_from_player(item)		

func drop_item_from_player(item_id):
	var ground_item = ItemConverter.create_ground_item(item_id)
		
	var radius = 20
	var angle
	var pos = player.position + Vector2(0, radius)
	# get valid item position
#	var i = 0
#	while !is_valid_item_position(current_room.to_local(pos)):
#		angle = deg2rad(randi() % 360)
#		pos = get_random_circle_point(radius, player.position)
#		i +=  1
#		if i >= 360:
#			radius += 10

	ground_item.position = pos
	ground_item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(ground_item)

# check if there is a wall at the position
func is_valid_item_position(local_item_pos):
	var cell = current_room.is_item_tile(local_item_pos)
	if FLOOR_TILES.find(cell) != -1:
		var occupied = false
		# check if there already is an item at that spot
		for item in get_items():
			if current_room.room_world_to_map(current_room.to_global(local_item_pos)) == current_room.room_world_to_map(item.position):
				occupied = true
		# check is the hero is standing in that spot
		if current_room.room_world_to_map(current_room.to_global(local_item_pos)) == current_room.room_world_to_map(hero.position):
			occupied = true
		return !occupied
	else:
		return false

func _on_loot_timeout():
	time_up = true
	for item in get_items():
		item.queue_free()

func blink_items():
	for item in get_items():
		item.blink()

func get_items():
	return get_tree().get_nodes_in_group("items")

func on_item_despawn(item):
	if time_up:
		item.queue_free()

func on_room_add_item(item):
	item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(item)

static func get_random_circle_point(radius, origin):
	var angle = deg2rad(randi() % 360)
	return Vector2(radius*sin(angle), radius*cos(angle)) + origin
