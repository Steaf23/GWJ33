extends Node

func to_bag(ground_item):
	if ground_item != null:
		return load("res://scenes/bag_items/" + ground_item.id + "BagItem.tscn").instance()

func to_ground(bag_item):
	return create_ground_item(bag_item.id)

func create_ground_item(item_id):
	var item = load("res://scenes/GroundItem.tscn").instance()
	item.id = item_id
	return item
