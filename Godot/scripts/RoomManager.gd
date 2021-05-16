extends Node2D

const UNIQUE_ROOM_COUNT = 1

onready var current_room

func _ready():
	add_room()

func get_next_room():
	return load("res://scenes/rooms/Room" + str(randi() % UNIQUE_ROOM_COUNT) + ".tscn")

func add_room():
	var new_room = get_next_room().instance()
	var extents = get_room_extents(get_children().back())
	var new_pos = Vector2(0, extents[0].y - get_room_height(get_children().back()))
	print("adding room to %s" % new_pos)
	new_room.position = new_pos
	current_room = new_room
	add_child(new_room)
	fill_room(10)

func fill_room(amount):
	for i in range(amount):
		var item = ItemConverter.create_ground_item("")
		# get a random tile position
		# convert it to global world position
		var extents = get_room_extents(current_room)
		var tl_cell = current_room.world_to_map(extents[0])
		var br_cell = current_room.world_to_map(extents[1])
		var extension = Vector2(abs(abs(tl_cell.x) - abs(br_cell.x)), 
								abs(abs(tl_cell.y) - abs(br_cell.y)))
		var rand_x = randi() % int(extension.x) + tl_cell.x
		var rand_y = randi() % int(extension.y) + br_cell.y
		var pos = current_room.to_global(current_room.map_to_world(Vector2(rand_x, rand_y)))
		while !is_valid_item_position(pos):
			rand_x = randi() % int(extension.x) + tl_cell.x
			rand_y = randi() % int(extension.y) + br_cell.y
			pos = current_room.to_global(current_room.map_to_world(Vector2(rand_x, rand_y)))
		# set the position to offset of 16 , 16, to be in the middle of the tile
		item.position = pos + Vector2(16, 16)
		spawn_item(item)

func remove_room(room):
	room.queue_free()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		add_room()

func get_all_items():
	var items = []
	for room in get_children():
		for item in room.get_children():
			items.append(item)
	return items

func spawn_item(item):
	if current_room != null:
		item.position = current_room.to_local(item.position)
		current_room.add_child(item)
	else:
		print("Can't find room at %s to spawn %sItem" % [item.position, item.id])	
	
func get_room_height(room: TileMap):
	var extents = get_room_extents(room)
	return abs(abs(extents[0].y) - abs(extents[1].y))

func get_room_extents(room: TileMap):
	var top_left = Vector2.ZERO
	var bottom_right = Vector2.ZERO
	for pos in room.get_used_cells():
		if pos.x < top_left.x:
			top_left.x = int(pos.x)
		elif pos.x > bottom_right.x:
			bottom_right.x = int(pos.x)
		if pos.y < top_left.y:
			top_left.y = int(pos.y)
		elif pos.y > bottom_right.y:
			bottom_right.y = int(pos.y)
	return [room.to_global(room.map_to_world(top_left)), 
			room.to_global(room.map_to_world(bottom_right))]
	
func get_room_on_position(pos):
	for room in get_children():
		var extents = get_room_extents(room)
		if pos.x > extents[0].x && pos.y > extents[0].y && pos.y < extents[1].y && pos.y < extents[1].y:
			return room
	return null

# check if there is a wall at the position
func is_valid_item_position(global_item_pos):
	for room in get_children():
		if room.get_cellv(room.world_to_map(room.to_local(global_item_pos))) != -1:
			return false
	return true
