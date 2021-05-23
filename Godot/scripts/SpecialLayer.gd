extends TileMap

enum {ITEM=0, 
	  DOOR_EXIT=1, 
	  DOOR_ENTER=2, 
	  STAIR_RIGHT=3, 
	  STAIR_LEFT=4, 
	  STAIR_TOP=5}

func get_door_tiles():
	var doors = [Vector2.ZERO, Vector2.ZERO]
	for cell in get_used_cells():
		if get_cellv(cell) == DOOR_ENTER:
			doors[0] = map_to_world(cell)
		if get_cellv(cell) == DOOR_EXIT:
			doors[1] = map_to_world(cell)
	return doors

func get_item_tiles():
	return get_used_cells_by_id(ITEM)
	
func is_item_tile(cell):
	return get_item_tiles().find(cell) != -1

func get_slope_transform(player_pos):
	var tile =get_cellv(world_to_map(player_pos))
	match tile:
		STAIR_LEFT:
			return 1
		STAIR_RIGHT:
			return 2
		STAIR_TOP:
			return 3
		_:
			return 0
