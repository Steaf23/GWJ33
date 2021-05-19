extends TileMap

enum {BRICKS=0, CLOSED_DOOR=1, OPEN_DOOR=2, STAIR_LEFT=3, STAIR_RIGHT=4, STAIR_TOP=5}

func get_extents():
	var top_left = Vector2.ZERO
	var bottom_right = Vector2.ZERO
	for pos in get_used_cells():
		if pos.x < top_left.x:
			top_left.x = int(pos.x)
		elif pos.x > bottom_right.x:
			bottom_right.x = int(pos.x)
		if pos.y < top_left.y:
			top_left.y = int(pos.y)
		elif pos.y > bottom_right.y:
			bottom_right.y = int(pos.y)
	return [to_global(map_to_world(top_left)), 
			to_global(map_to_world(bottom_right))]

func close_door():
	for cell in get_used_cells_by_id(OPEN_DOOR):
		set_cellv(cell, CLOSED_DOOR)

func open_door():
	for cell in get_used_cells_by_id(CLOSED_DOOR):
		set_cellv(cell, OPEN_DOOR)
		
func apply_slope_transform(player, movedir):
	var player_pos = to_local(player.position)
	match get_cellv(world_to_map(player_pos)):
		STAIR_LEFT:
			player.on_stair = 1
		STAIR_RIGHT:
			player.on_stair = 2
		STAIR_TOP:
			player.on_stair = 3
		_:
			player.on_stair = 0
