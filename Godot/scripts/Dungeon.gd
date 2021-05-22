extends Node2D

const FLOOR_TILE = 6
const UNIQUE_ROOM_COUNT = 2
const ROOM_DISTANCE = 0

signal request_item_pickup(item)
signal start_battle()

var time_up = false

onready var player = $YSort/Player
onready var hero = $YSort/Hero
onready var objectList = $YSort
onready var preload_rooms = []
onready var current_room

func _ready():
	player.connect("request_pickup", self, "on_player_request_pickup")
	fill_room_list()
	setup_start_room()
	player.position = current_room.door_exit

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
	emit_signal("request_item_pickup", null)
	# prevent the same room to be generated twice in a row
	
	var tween = player.move_to(Vector2(current_room.door_entrance.x, player.position.y), .5)
	yield(tween, "tween_completed")
	# duration should be 10 for battle sequence
	tween = player.move_to(player.position, 2)
	# ADD BATTLE MUSIC STUFF HERE
	yield(tween, "tween_completed")
	
	current_room.open_door()
	var new_room = instance_random_room()
	while new_room.id == current_room.id:
		new_room = instance_random_room()
	setup_room(new_room)
	current_room.open_door()
	tween = player.move_to(Vector2(player.position.x, current_room.door_exit.y), 1)
	yield(tween, "tween_completed")
	current_room.close_door()
	Score.room_score += 1
	print("total rooms: %d" % Score.room_score)

func setup_start_room():
	var starting_room = load("res://scenes/rooms/RoomStart.tscn").instance()
	objectList.add_child(starting_room)
	
	starting_room.position = Vector2(0, 0)
	starting_room.set_room_extents()
	
	player.camera.set_new_limits(starting_room.limits)
	hero.position = starting_room.door_entrance + Vector2(0, 32)
	current_room = starting_room
	return starting_room

func setup_room(new_room):
	objectList.add_child(new_room)
	
	new_room.position = current_room.door_entrance - new_room.door_exit - Vector2(0, 32)
	new_room.position.y = new_room.position.y - 32 - ROOM_DISTANCE
#		current_room.queue_free()
	new_room.set_room_extents()
	
	player.camera.set_new_limits(new_room.limits)
	hero.position = new_room.door_entrance + Vector2(0, 32)
	hero.collision.disabled = false
	current_room = new_room
	generate_items(10)
	return new_room

func get_colliding_items():
	var colliding_items = []
	for item in get_items():
		if item.get_player() != null:
			colliding_items.append(item)
	return colliding_items

func on_player_request_pickup():
	var items = get_colliding_items()
	if items.size() > 0:
		var item = get_colliding_items()[0] #pass by value
		player.show_bag = true
		emit_signal("request_item_pickup", item) # pass by value, which might be deleted at that point (if zooming is enabled)
		return

	if hero.get_player() != null:
		emit_signal("start_battle")
		
func generate_items(percentage):
	if percentage >= 100:
		percentage = 99
	var amount = current_room.get_max_amount_items(FLOOR_TILE, percentage)
	var ground_tiles = current_room.get_all_room_tiles_by_id(FLOOR_TILE)
	
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

func drop_items_from_player(items):
	for item in items:
		drop_item_from_player(item)		

func drop_item_from_player(ground_item):
	var radius = 20
	var angle
	var pos = player.position + Vector2(0, radius)
	# get valid item position
	var i = 0
	while !is_valid_item_position(current_room.to_local(pos)):
		angle = deg2rad(randi() % 360)
		pos = get_random_circle_point(radius, player.position)
		i +=  1
		if i >= 360:
			radius += 10

	ground_item.position = pos
	ground_item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(ground_item)

# check if there is a wall at the position
func is_valid_item_position(local_item_pos):
	var cell = current_room.get_first_tile_at(local_item_pos)
	if cell == FLOOR_TILE:
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

func get_random_circle_point(radius, origin):
	var angle = deg2rad(randi() % 360)
	return Vector2(radius*sin(angle), radius*cos(angle)) + origin

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
