extends TileMap

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
