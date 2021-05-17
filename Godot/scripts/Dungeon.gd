extends Node2D

signal request_item_pickup(item)

var time_up = false
var current_room

onready var player = $YSort/Player
onready var hero = $YSort/Hero
onready var objectHolder = $YSort

func _ready():
	player.connect("request_pickup", self, "on_player_request_pickup")
	generate_items(10)

func get_colliding_items():
	var colliding_items = []
	for item in get_items():
		if item.get_player() != null:
			colliding_items.append(item)
	return colliding_items

func on_player_request_pickup():
	if get_colliding_items().size() > 0:
		var item = get_colliding_items()[0]
		emit_signal("request_item_pickup", item)
		return
		
	if hero.get_player() != null:
		force_next_room()

func drop_item_from_player(ground_item):
	if time_up:
		ground_item.queue_free()
	else: 	
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
		objectHolder.add_child(ground_item)

func _on_loot_timeout():
	time_up = true
	for item in get_items():
		item.queue_free()

func blink_items():
	for item in get_items():
		item.blink()

func force_next_room():
	var tween = player.move_to(Vector2(240, player.position.y), .5)
	yield(tween, "tween_completed")
	player.move_to(Vector2(240, -16), 1)
	pass

# called when the player moves into a new room
func start_next_room():
#	roomManager.add_room()
#	roomManager.fill_room(1)
	pass
	
# check if there is a wall at the position
func is_valid_item_position(global_item_pos):
	for room in get_rooms():
		if room.get_cellv(room.world_to_map(room.to_local(global_item_pos))) != -1:
			return false
	return true

func generate_items(amount):
	for i in range(amount):
		var item = ItemConverter.create_ground_item(ItemLookup.get_random_item_name())
		# get a random tile position
		# convert it to global world position
		var current_room = get_rooms()[0]
		var extents = current_room.get_extents()
		var tl_cell = current_room.world_to_map(extents[0])
		var br_cell = current_room.world_to_map(extents[1])
		var extension = Vector2(abs(abs(tl_cell.x) - abs(br_cell.x)), 
								abs(abs(tl_cell.y) - abs(br_cell.y)))
		var rand_x
		var rand_y
		var pos = Vector2.ZERO
		while !is_valid_item_position(pos):
			rand_x = randi() % int(extension.x) + tl_cell.x
			rand_y = randi() % int(extension.y) + tl_cell.y
			pos = current_room.to_global(current_room.map_to_world(Vector2(rand_x, rand_y)))
		# set the position to offset of 16 , 16, to be in the middle of the tile
		item.position = pos + Vector2(16, 16)
		objectHolder.add_child(item)

func get_rooms():
	return get_tree().get_nodes_in_group("rooms")

func get_items():
	return get_tree().get_nodes_in_group("items")
