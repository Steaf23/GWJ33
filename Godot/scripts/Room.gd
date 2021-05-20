extends Node2D

enum {BRICKS=0, CLOSED_DOOR=1, OPEN_DOOR=2, STAIR_LEFT=3, STAIR_RIGHT=4, STAIR_TOP=5}

var id = -1

onready var groundLayer = $Ground
onready var wallLayer = $Wall
onready var limits = $Limits
onready var door_pos = $Door/New
onready var door_connection = $Door/Old
onready var layers = [groundLayer, wallLayer]

func _ready():
	find_doors()

func find_doors():
	for cell in wallLayer.get_used_cells():
		if wallLayer.get_cellv(cell) == CLOSED_DOOR:
			door_pos.position = wallLayer.map_to_world(cell)
		elif wallLayer.get_cellv(cell) == OPEN_DOOR:
			door_connection.position = wallLayer.map_to_world(cell)

func close_door():
	for cell in wallLayer.get_used_cells_by_id(OPEN_DOOR):
		wallLayer.set_cellv(cell, CLOSED_DOOR)

func open_door():
	for cell in wallLayer.get_used_cells_by_id(CLOSED_DOOR):
		wallLayer.set_cellv(cell, OPEN_DOOR)

func apply_slope_transform(player):
	var player_pos = to_local(player.position)
	match groundLayer.get_cellv(groundLayer.world_to_map(player_pos)):
		STAIR_LEFT:
			player.on_stair = 1
		STAIR_RIGHT:
			player.on_stair = 2
		STAIR_TOP:
			player.on_stair = 3
		_:
			player.on_stair = 0

func get_global_door():
	return to_global(door_pos.position)

func get_ground_tile_at(pos):
	return groundLayer.get_cellv(get_ground_cellv(pos))

func get_ground_cellv(pos):
	print(groundLayer.world_to_map(pos))
	return groundLayer.world_to_map(pos)

func set_room_extents():
	limits.set_room_extents(groundLayer, wallLayer)
