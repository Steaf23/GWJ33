extends Node2D

enum {BRICKS=0, CLOSED_DOOR=1, OPEN_DOOR=2, STAIR_LEFT=3, STAIR_RIGHT=4, STAIR_TOP=5}

var id = -1

onready var groundLayer = $Ground
onready var wallLayer = $Wall
onready var limits = $Limits setget ,get_limits
onready var door_entrance = $Door/New setget ,get_global_entrance
onready var door_exit = $Door/Old setget ,get_global_exit
onready var layers = [groundLayer, wallLayer]

func _ready():
	find_doors()

func find_doors():
	for cell in wallLayer.get_used_cells():
		if wallLayer.get_cellv(cell) == CLOSED_DOOR:
			door_entrance.position = wallLayer.map_to_world(cell)
		elif wallLayer.get_cellv(cell) == OPEN_DOOR:
			door_exit.position = wallLayer.map_to_world(cell)

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

func get_ground_tile_at(pos):
	return groundLayer.get_cellv(get_ground_cellv(pos))

func get_ground_cellv(pos):
	return groundLayer.world_to_map(pos)

func set_room_extents():
	limits.set_room_extents(groundLayer, wallLayer)

func get_max_amount_items(spawning_tile_id, percentage):
	var tiles = groundLayer.get_used_cells_by_id(spawning_tile_id)
	return tiles.size() * percentage / 100

func get_global_entrance():
	return to_global(door_entrance.position) + Vector2(16, 16)

func get_global_exit():
	return to_global(door_exit.position) + Vector2(16, -16)

func ground_map_to_world(cell):
	return groundLayer.map_to_world(cell)
	
func get_limits():
	return limits.get_limits()
