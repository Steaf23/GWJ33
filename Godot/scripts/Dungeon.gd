extends Node2D

signal request_item_pickup(item)

var time_up = false

onready var room = $Room
onready var player = $Player

func _process(delta):
	room.get_children()

func get_colliding_items():
	var colliding_items = []
	for child in room.get_children():
		if child is Area2D:
			if child.get_player() != null:
				colliding_items.append(child)
	return colliding_items

func on_player_request_pickup():
	if get_colliding_items().size() > 0:
		var item = get_colliding_items()[0]
		emit_signal("request_item_pickup", item)

func get_next_room():
	return "res://scenes/rooms/room_" + str(randi() % 20).pad_zeros(3) + ".tscn"

func _on_loot_timeout():
	time_up = true
	for child in room.get_children():
		child.queue_free()

func blink_items():
	for child in room.get_children():
		child.blink()
		
func drop_item_from_player(ground_item):
	if time_up:
		ground_item.queue_free()
	else:	
		var radius = 20
		var angle = deg2rad(randi() % 360)
		var pos = Vector2(radius*sin(angle), radius*cos(angle))
		ground_item.position = player.position + pos
		room.add_child(ground_item)
	
