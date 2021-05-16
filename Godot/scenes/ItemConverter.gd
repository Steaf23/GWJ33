extends Node

func to_bag(ground_item):
	return load("res://scenes/bag_items/" + ground_item.id + "BagItem.tscn").instance()

func to_ground(bag_item):
	var ground_item = load("res://scenes/ground_items/GroundItem.tscn").instance()
	ground_item.id = bag_item.id
	return ground_item
