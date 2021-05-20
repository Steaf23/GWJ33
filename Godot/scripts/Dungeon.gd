extends Node2D

const FLOOR_TILE = 6

signal request_item_pickup(item)

var time_up = false
var room_counter = 0
var UNIQUE_ROOM_COUNT = 2

onready var player = $YSort/Player
onready var hero = $YSort/Hero
onready var objectList = $YSort
onready var riskHandler = $RiskHandler
onready var roomHolder = {}
onready var room = $YSort/Room

func _ready():
	player.connect("request_pickup", self, "on_player_request_pickup")
	generate_items(100)

func generate_items(amount):
	for i in range(amount):
		var item = ItemConverter.create_ground_item(ItemLookup.get_random_item_name())
		# get a random tile position
		# convert it to global world position
		var tl_cell = room.groundLayer.world_to_map(get_layer_extents(room.groundLayer)[0])
		var br_cell = room.groundLayer.world_to_map(get_layer_extents(room.groundLayer)[1])
		var extension = Vector2(abs(abs(tl_cell.x) - abs(br_cell.x)), 
								abs(abs(tl_cell.y) - abs(br_cell.y)))
								
		var rand_x = randi() % int(extension.x) + tl_cell.x
		var	rand_y = randi() % int(extension.y) + tl_cell.y
		var	pos = room.groundLayer.to_global(room.groundLayer.map_to_world(Vector2(rand_x, rand_y)))
		
		while !is_valid_item_position(pos):
			rand_x = randi() % int(extension.x) + tl_cell.x
			rand_y = randi() % int(extension.y) + tl_cell.y
			pos = room.groundLayer.to_global(room.groundLayer.map_to_world(Vector2(rand_x, rand_y)))
		# set the position to offset of 16 , 16, to be in the middle of the tile
		item.position = pos + Vector2(16, 16)
		objectList.add_child(item)

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
	var room_cell = room.groundLayer.world_to_map(room.groundLayer.to_local(global_item_pos))
	if room.groundLayer.get_cellv(room_cell) != FLOOR_TILE:
		return false
	return true

func get_random_room():
	return load("res://scenes/rooms/Room" + "" + ".tscn").instance()

func _process(delta):
	pass

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
		var tween = player.camera.zoom_in()
		yield(tween, "tween_completed")
		emit_signal("request_item_pickup", item) # pass by value, which might be deleted at that point
		return

	if hero.get_player() != null:
		force_next_room()

func drop_item_from_player(ground_item):
	var radius = 20
	var angle
	var pos = Vector2.ZERO
	# get valid item position
	var i = 0
	while !is_valid_item_position(pos):
		angle = deg2rad(randi() % 360)
		pos = Vector2(radius*sin(angle), radius*cos(angle)) + player.position
		i +=  1
		if i >= 360:
			radius += 10

	ground_item.position = pos
	ground_item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(ground_item)

func _on_loot_timeout():
	time_up = true
	for item in get_items():
		item.queue_free()

func blink_items():
	for item in get_items():
		item.blink()

func force_next_room():
	emit_signal("request_item_pickup", null)
	start_next_room()
	var tween = player.move_to(Vector2(240, player.position.y), .5)
	yield(tween, "tween_completed")
	tween = player.move_to(player.position, 2)
	# ADD BATTLE MUSIC STUFF HERE
	yield(tween, "tween_completed")
	room.open_door()
	tween = player.move_to(Vector2(240, -16), 1)
	yield(tween, "tween_completed")
	room.close_door()
	room_counter += 1
	pass

# called when the player moves into a new room
func start_next_room():
#	roomManager.add_room()
#	roomManager.fill_room(1)
	pass

func get_items():
	return get_tree().get_nodes_in_group("items")

func on_item_despawn(item):
	if time_up:
		item.queue_free()

func on_room_add_item(item):
	item.connect("despawn", self, "on_item_despawn")
	objectList.add_child(item)

