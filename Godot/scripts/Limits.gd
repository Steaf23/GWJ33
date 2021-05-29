extends Node

onready var topLeft = $TopLeft
onready var bottomRight = $BottomRight

onready var tl_label = $TopLeft/Label
onready var br_label = $BottomRight/Label 

func get_limits():
	return [topLeft.position, bottomRight.position]

func set_room_extents(layers):
	var extents = []
	for layer in layers:
		extents.append(get_layer_extents(layer))
	
	var total = [Vector2(0, 0), Vector2(0, 0)]
	for extent in extents:
		total = [get_smallest_vector(extent[0], total[0]), get_biggest_vector(extent[1], total[1])] 
	topLeft.position = total[0]
	bottomRight.position = total[1] + Vector2(32, 32)
	
	tl_label.text = "(%d, %d) \n (%d, %d)" % [topLeft.position.x, 
											  topLeft.position.y, 
											  topLeft.position.x / 32, 
											  topLeft.position.y / 32]
	br_label.text = "(%d, %d) \n (%d, %d)" % [bottomRight.position.x, 
											  bottomRight.position.y, 
											  bottomRight.position.x / 32, 
											  bottomRight.position.y / 32]

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
	return [layer.to_global(layer.map_to_world(top_left)), 
			layer.to_global(layer.map_to_world(bottom_right))]
			
static func get_smallest_vector(v1, v2):
	return Vector2(min(v1.x, v2.x), min(v1.y, v2.y))

static func get_biggest_vector(v1, v2):
	return Vector2(max(v1.x, v2.x), max(v1.y, v2.y))
	
