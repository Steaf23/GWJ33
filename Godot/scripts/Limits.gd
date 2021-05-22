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
		total = [Vector2(min(extent[0].x, total[0].x), min(extent[0].y, total[0].y)), 
				 Vector2(max(extent[1].x, total[1].x), max(extent[1].y, total[1].y))]
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
