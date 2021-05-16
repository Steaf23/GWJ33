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
	
func get_stat(item_id, enemy_id):
	return item_data[item_id][enemy_id]	