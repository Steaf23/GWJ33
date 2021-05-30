extends Node2D

var id = -1

onready var limits = $Limits setget ,get_limits
onready var door_entrance = $DoorPos/New setget ,get_global_entrance
onready var door_exit = $DoorPos/Old setget ,get_global_exit
onready var specialLayer = $SpecialLayer
onready var warningSign = preload("res://scenes/Sign.tscn")

onready var door = $Door

onready var layers = []
onready var warning

func _ready():
	for child in get_children():
		if child is TileMap:
			layers.append(child)
	layers.invert()
	find_doors()
	create_warning_signs()

func create_warning_signs():
	for cell in specialLayer.get_sign_tiles():
		var warning_sign = warningSign.instance()
		add_child(warning_sign)
		warning_sign.set_monster(warning)
		warning_sign.position = specialLayer.map_to_world(cell) + Vector2(16, 8)

func close_door():
	door.close_door()
#	for layer in layers:
#		var cells = []
#		for cell in layer.get_used_cells_by_id('open_door'):
#			cells.append(cell)
#			layer.set_cellv(cell, tiles['closed_door'][0])

func open_door():
	door.open_door()
#	for layer in layers:
#		for cell in layer.get_used_cells_by_id('closed_door'):
#			layer.set_cellv(cell, tiles['open_door'][0])

func apply_slope_transform(player):
	player.on_stair = specialLayer.get_slope_transform(to_local(player.position))


func get_highest_tile_at(pos):
	for layer in layers:
		var tile = layer.get_cellv(room_world_to_map(pos))
		if tile != -1:
			return tile
	return -1

func room_world_to_map(pos):
	return layers[0].world_to_map(pos)

func set_room_extents():
	limits.set_room_extents(layers)

func get_max_amount_items(percentage):
	var tiles = specialLayer.get_item_tiles()
	return tiles.size() * percentage / 100

func get_all_room_tiles_by_id(tile_id):
	var tiles = []
	for layer in layers:
		tiles.append_array(layer.get_used_cells_by_id(tile_id))
	return tiles

func get_global_entrance():
	return to_global(specialLayer.get_door_tiles()[0]) + Vector2(16, 16)

func get_global_exit():
	return to_global(specialLayer.get_door_tiles()[1]) + Vector2(16, -16)

func room_map_to_world(cell):
	return to_global(layers[0].map_to_world(cell))
	
func get_limits():
	return limits.get_limits()
	
func find_doors():
	door_entrance.position = specialLayer.get_door_tiles()[0]
	door_exit.position = specialLayer.get_door_tiles()[1]

func is_item_tile(local_item_pos):
	return specialLayer.is_item_tile(room_world_to_map(local_item_pos))
