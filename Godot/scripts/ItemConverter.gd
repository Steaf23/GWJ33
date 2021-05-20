extends Node

func to_bag(ground_item):
	if ground_item != null:
		return create_bag_item(ground_item.id)

func to_ground(bag_item):
	return create_ground_item(bag_item.id)

func create_ground_item(item_id):
	var item = load("res://scenes/GroundItem.tscn").instance()
	item.id = item_id
	item.z_index = 50
	return item

func create_bag_item(item_id):
	return load("res://scenes/bag_items/" + item_id + "BagItem.tscn").instance()
