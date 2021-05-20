extends Node2D

const FLOOR_TILE = 6
const UNIQUE_ROOM_COUNT = 2

signal request_item_pickup(item)

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
#	generate_items(50)

func generate_items(amount):
	for i in range(amount):
		var item = ItemConverter.create_ground_item(ItemLookup.get_random_item_name())
		# get a random tile position
		# convert it to global world position
		var tl_cell = current_room.groundLayer.world_to_map(get_layer_extents(current_room.groundLayer)[0])
		var br_cell = current_room.groundLayer.world_to_map(get_layer_extents(current_room.groundLayer)[1])
		var extension = Vector2(abs(abs(tl_cell.x) - abs(br_cell.x)), 
								abs(abs(tl_cell.y) - abs(br_cell.y)))
					
		var rand_x = randi() % int(extension.x) + tl_cell.x
		var	rand_y = randi() % int(extension.y) + tl_cell.y
		var	pos = current_room.groundLayer.to_global(current_room.groundLayer.map_to_world(Vector2(rand_x, rand_y)))
		
		while !is_valid_item_position(pos):
			rand_x = randi() % int(extension.x) + tl_cell.x
			rand_y = randi() % int(extension.y) + tl_cell.y
			pos = current_room.groundLayer.to_global(current_room.groundLayer.map_to_world(Vector2(rand_x, rand_y)))
		# set the position to offset of 16 , 16, to be in the middle of the tile
		item.position = pos + Vector2(16, 16)
		objectList.add_child(item)
		print("generated %d items" % [i + 1])

func get_layer_extents(layer):
	var top_left = Vector2.ZERO
	var bottom_right = Vector2.ZERO
	for pos in layer.get_used_cells():
		if pos.x < top_left.x:
			top_left.x = int(pos.x)
		elif pos.x > bottom_right.x:
			bottom_right.x = int(pos.x)
		if pos.y < top_left.y:
			top_left.y = int(pos.y)
		elif pos.y > bottom_right.y:
			bottom_right.y = int(pos.y)
	return [layer.map_to_world(top_left), 
			layer.map_to_world(bottom_right)]

# check if there is a wall at the position
func is_valid_item_position(global_item_pos):
	if current_room.get_ground_tile_at(global_item_pos) == FLOOR_TILE:
		var occupied = false
		for item in get_items():
			if current_room.get_ground_cellv(global_item_pos) == current_room.get_ground_cellv(item.position):
				occupied = true
		return !occupied
	else:
		return false

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

func drop_item_from_player(ground_item):
	var radius = 20
	var angle
	var pos = player.position + Vector2(0, radius)
	# get valid item position
	var i = 0
	while !is_valid_item_position(pos):
		angle = deg2rad(randi() % 360)
		pos = get_random_circle_point(radius, player.position)
		i +=  1
		if i >= 360:
			radius += 10

	ground_item.position = pos
	ground_item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(ground_item)
	
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
#	var old_hero_pos = hero.position
#	setup_room(instance_random_room())
#	var tween = player.move_to(Vector2(old_hero_pos.x, old_hero_pos.y), .5)
#	yield(tween, "tween_completed")
#	tween = player.move_to(player.position, 2)
#	# ADD BATTLE MUSIC STUFF HERE
#	yield(tween, "tween_completed")
#	current_room.open_door()
#	tween = player.move_to(Vector2(old_hero_pos.x, old_hero_pos.y - 64), 1)
#	yield(tween, "tween_completed")
#	current_room.close_door()
	# prevent the same room to be generated twice in a row
	var new_room = instance_random_room()
	while new_room.id == current_room.id:
		new_room = instance_random_room()
	setup_room(new_room)
	room_counter += 1
	print("total rooms: %d" % room_counter)
	pass

func setup_room(new_room):
	objectList.add_child(new_room)
	if current_room == null:
		new_room.position = Vector2(0,0)
	else:
		new_room.position = current_room.get_global_door() - new_room.to_global(new_room.door_connection.position)
#		current_room.queue_free()
	new_room.set_room_extents()
	player.camera.set_new_limits(new_room.limits.get_global_limits())
	current_room = new_room
	hero.position = current_room.get_global_door() + Vector2(16, 48)
	return new_room

func get_items():
	return get_tree().get_nodes_in_group("items")

func on_item_despawn(item):
	if time_up:
		item.queue_free()

func on_room_add_item(item):
	item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(item)

