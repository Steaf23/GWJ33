extends Node

onready var item_data

func _ready():
	item_data = load_items()

func load_items(file_name="res://resources/item_stats.json"):
	var file = File.new()
	if file.file_exists(file_name):
		file.open(file_name, File.READ)
		var content = parse_json(file.get_as_text())
		file.close()
		return content
	return {}
	
func get_success_rate(item_id="", enemy_id="default"):
	if item_id == "":
		return 0
	return item_data[item_id]['success'][enemy_id]	

func get_type(item_id):
	return item_data[item_id]["type"]
	
func get_rarity(item_id):
	return item_data[item_id]["rarity"]

func get_random_item_name():
	return item_data.keys()[randi() % item_data.keys().size()]
