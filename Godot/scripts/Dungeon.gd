extends Node2D

signal request_item_pickup(item)

var time_up = false

onready var roomManager = $RoomManager
onready var player = $Player

func get_colliding_items():
	var colliding_items = []
	for item in roomManager.get_all_items():
		if item.get_player() != null:
			colliding_items.append(item)
	return colliding_items

func on_player_request_pickup():
	if get_colliding_items().size() > 0:
		var item = get_colliding_items()[0]
		emit_signal("request_item_pickup", item)

func drop_item_from_player(ground_item):
	if time_up:
		ground_item.queue_free()
	else:	
		var radius = 20
		var angle = deg2rad(randi() % 360)
		var pos = Vector2(radius*sin(angle), radius*cos(angle))
		ground_item.position = player.position + pos
		roomManager.spawn_item(ground_item)

func _on_loot_timeout():
	time_up = true
	for item in roomManager.get_all_items():
		item.queue_free()

func blink_items():
	for item in roomManager.get_all_items():
		item.blink()

