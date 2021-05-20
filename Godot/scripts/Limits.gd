extends Node2D

onready var topLeft = $TopLeft
onready var bottomRight = $BottomRight

func get_global_limits():
	return [to_global(topLeft.position), to_global(bottomRight.position)]

func set_room_extents(ground_layer, wall_layer):
	var g_ex = get_layer_extents(ground_layer)
	var w_ex = get_layer_extents(wall_layer)
	print("ground extents: " + str(g_ex))
	print("wall extents: " + str(w_ex))
	var extents = [Vector2(min(g_ex[0].x, w_ex[0].x), min(g_ex[0].y, w_ex[0].y)), 
				   Vector2(max(g_ex[1].x, w_ex[1].x), max(g_ex[1].y, w_ex[1].y))]
	topLeft.position = extents[0]
	bottomRight.position = extents[1]

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
