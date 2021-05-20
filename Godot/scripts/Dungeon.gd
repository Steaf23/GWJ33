extends Node2D

const FLOOR_TILE = 6
const UNIQUE_ROOM_COUNT = 2
const ROOM_DISTANCE = 0

signal request_item_pickup(item)
signal new_room()

var time_up = false
var room_counter = 0

onready var player = $YSort/Player
onready var hero = $YSort/Hero
onready var objectList = $YSort
onready var riskHandler = $RiskHandler
onready var preload_rooms = []
onready var current_room

func _ready():
	player.connect("request_pickup", self, "on_player_request_pickup")
	fill_room_list()
	setup_room(instance_random_room())
	player.position = current_room.door_connection.position + Vector2(16, -16)

func fill_room_list():
	for i in range(UNIQUE_ROOM_COUNT):
		preload_rooms.append(load("res://scenes/rooms/Room" + str(i) + ".tscn"))

func instance_random_room():
	var room_id = randi() % UNIQUE_ROOM_COUNT
	print("picking Room%d as next room" % [room_id])
	var new_room = preload_rooms[room_id].instance()
	new_room.id = room_id
	return new_room

func _process(delta):
	current_room.apply_slope_transform(player)

func get_colliding_items():
	var colliding_items = []
	for item in get_items():
		if item.get_player() != null:
			colliding_items.append(item)
	return colliding_items

func on_player_request_pickup():
	if get_colliding_items().size() > 0:
		var item = get_colliding_items()[0] #pass by value
		player.in_bag = true
		emit_signal("request_item_pickup", item) # pass by value, which might be deleted at that point
		return

	if hero.get_player() != null:
		force_next_room()
		
func generate_items(amount):
	var gen = RandomNumberGenerator.new()
	gen.randomize()
	var groundLayer = current_room.groundLayer
	var limits = current_room.limits.get_limits()
	limits[1] -= Vector2(32, 32)
	var tl_cell = groundLayer.world_to_map(limits[0])
	var br_cell = groundLayer.world_to_map(limits[1])
	
	for i in range(amount):
		var item = ItemConverter.create_ground_item(ItemLookup.get_random_item_name())
		# get a random tile position
		# convert it to global world position
		
		var rand_x = gen.randi_range(tl_cell.x, br_cell.x)
		var rand_y = gen.randi_range(tl_cell.y, br_cell.y)
		var	pos = groundLayer.map_to_world(Vector2(rand_x, rand_y))
		
		while !is_valid_item_position(current_room.to_local(pos)):
			rand_x = gen.randi_range(tl_cell.x, br_cell.x)
			rand_y = gen.randi_range(tl_cell.y, br_cell.y)
			pos = groundLayer.map_to_world(Vector2(rand_x, rand_y))
		# set the position to offset of 16 , 16, to be in the middle of the tile
		item.position = pos + Vector2(16, 16)
		objectList.add_child(item)
		
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
	var cell = current_room.get_ground_tile_at(local_item_pos)
	print(cell)
	if cell == FLOOR_TILE:
		var occupied = false
		for item in get_items():
			if current_room.get_ground_cellv(current_room.to_global(local_item_pos)) == current_room.get_ground_cellv(item.position):
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

func force_next_room():
#	emit_signal("request_item_pickup", null)
#	setup_room(instance_random_room())

	# prevent the same room to be generated twice in a row
	var new_room = instance_random_room()
	while new_room.id == current_room.id:
		new_room = instance_random_room()
	
	var tween = player.move_to(Vector2(current_room.to_global(current_room.door_pos.position).x + 16, player.position.y), .5)
	yield(tween, "tween_completed")
	# duration should be 10 for battle sequence
	tween = player.move_to(player.position, 2)
	# ADD BATTLE MUSIC STUFF HERE
	yield(tween, "tween_completed")
	setup_room(new_room)
	current_room.open_door()
	tween = player.move_to(Vector2(player.position.x, player.position.y - 112), 1)
	yield(tween, "tween_completed")
	current_room.close_door()
	emit_signal("new_room")
	room_counter += 1
	print("total rooms: %d" % room_counter)
	pass

func setup_room(new_room):
	objectList.add_child(new_room)
	if current_room == null:
		new_room.position = Vector2(0,0)
	else:
		new_room.position = current_room.get_global_door() - new_room.to_global(new_room.door_connection.position)
		new_room.position.y = new_room.position.y - 32 - ROOM_DISTANCE
#		current_room.queue_free()
	new_room.set_room_extents()
	player.camera.set_new_limits(new_room.limits.get_limits())
	current_room = new_room
	hero.position = current_room.get_global_door() + Vector2(16, 48)
	generate_items(10)
	return new_room

func get_items():
	return get_tree().get_nodes_in_group("items")

func on_item_despawn(item):
	if time_up:
		item.queue_free()

func on_room_add_item(item):
	item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(item)

