extends Node2D

enum {BRICKS=0, CLOSED_DOOR=1, OPEN_DOOR=2, STAIR_LEFT=3, STAIR_RIGHT=4, STAIR_TOP=5}

var id = -1

onready var limits = $Limits setget ,get_limits
onready var door_entrance = $Door/New setget ,get_global_entrance
onready var door_exit = $Door/Old setget ,get_global_exit
onready var layers = []

onready var warning

func _ready():
	for child in get_children():
		if child is TileMap:
			layers.append(child)
	find_doors()

func find_doors():
	for layer in layers:
		for cell in layer.get_used_cells():
			if layer.get_cellv(cell) == CLOSED_DOOR:
				door_entrance.position = layer.map_to_world(cell)
			elif layer.get_cellv(cell) == OPEN_DOOR:
				door_exit.position = layer.map_to_world(cell)

func close_door():
	for layer in layers:
		for cell in layer.get_used_cells_by_id(OPEN_DOOR):
			layer.set_cellv(cell, CLOSED_DOOR)

func open_door():
	for layer in layers:
		for cell in layer.get_used_cells_by_id(CLOSED_DOOR):
			layer.set_cellv(cell, OPEN_DOOR)

func apply_slope_transform(player):
	var player_pos = to_local(player.position)
	match get_first_tile_at(player_pos):
		STAIR_LEFT:
			player.on_stair = 1
		STAIR_RIGHT:
			player.on_stair = 2
		STAIR_TOP:
			player.on_stair = 3
		_:
			player.on_stair = 0

func get_first_tile_at(pos):
	for layer in layers:
		var tile = layer.get_cellv(room_world_to_map(pos))
		if tile != -1:
			return tile
	return -1

func room_world_to_map(pos):
	return layers[0].world_to_map(pos)

func set_room_extents():
	limits.set_room_extents(layers)

func get_max_amount_items(spawning_tile_id, percentage):
	var tiles = get_all_room_tiles_by_id(spawning_tile_id)
	return tiles.size() * percentage / 100

func get_all_room_tiles_by_id(tile_id):
	var tiles = []
	for layer in layers:
		tiles.append_array(layer.get_used_cells_by_id(tile_id))
	return tiles

func get_global_entrance():
	return to_global(door_entrance.position) + Vector2(16, 16)

func get_global_exit():
	return to_global(door_exit.position) + Vector2(16, -16)

func room_map_to_world(cell):
	return to_global(layers[0].map_to_world(cell))
	
func get_limits():
	return limits.get_limits()
