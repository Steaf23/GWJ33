extends Node

func to_bag(ground_item):
	return load("res://scenes/bag_items/" + ground_item.id + "BagItem.tscn").instance()

func to_ground(bag_item):
	return create_ground_item(bag_item.id)

func create_ground_item(item_id):
	var item = load("res://scenes/ground_items/GroundItem.tscn").instance()
	item.id = item_id
	return item
