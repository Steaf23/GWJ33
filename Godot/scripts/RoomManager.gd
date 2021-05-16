extends Node2D

const UNIQUE_ROOM_COUNT = 1

func get_next_room():
	return load("res://scenes/rooms/Room" + str(randi() % UNIQUE_ROOM_COUNT) + ".tscn")

func add_room():
	var new_room = get_next_room().instance()
	var new_pos = Vector2(0, -get_room_height(get_children().back()))
	new_room.position = new_pos
	add_child(new_room)

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
	var room = get_room_on_position(item.position)
	if room != null:
		item.position = room.to_local(item.position)
		room.add_child(item)
	else:
		print("Can't find room at %s to spawn %sItem" % [item.position, item.id])	
	
func get_room_height(room: TileMap):
	var record_cell = Vector2.ZERO
	for cell in room.get_used_cells():
		if cell.y > record_cell.y:
			record_cell = cell
	return room.map_to_world(record_cell).y

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
	return [room.to_global(room.map_to_world(top_left)), room.to_global(room.map_to_world(bottom_right))]
	
func get_room_on_position(pos):
	for room in get_children():
		var extents = get_room_extents(room)
		if pos.x > extents[0].x && pos.y > extents[0].y && pos.y < extents[1].y && pos.y < extents[1].y:
			return room
	return null
