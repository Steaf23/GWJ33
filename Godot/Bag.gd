extends TileMap

const GRID_SIZE = 16

var bag_items
var held_item

func _process(delta):
	if held_item == null:
		pass	
		
func _input(event):
	if event is InputEventMouseMotion:
		if held_item != null:
			held_item.position = (get_global_mouse_position() - held_item.mouse_offset).snapped(Vector2(GRID_SIZE, GRID_SIZE))
	if event is InputEventMouseButton:
		# if let loose of the lmb;
		if !event.is_pressed():
			if held_item != null:
				held_item.picked_up = false
				held_item.drop()
				held_item.position = held_item.position.snapped(Vector2(GRID_SIZE, GRID_SIZE))
				held_item = null
		
func _on_ItemBlock_clicked_on(item):
	print("picked up %s" % [item.name])
	held_item = item
