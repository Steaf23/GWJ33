extends Node

#const UNIQUE_ROOM_COUNT = 1
#
#onready var current_room
#
#func _ready():
##	add_room()
#	pass
#
#func get_next_room():
#	return load("res://scenes/rooms/Room" + str(randi() % UNIQUE_ROOM_COUNT) + ".tscn")
#
#func add_room():
#	var new_room = get_next_room().instance()
#	var extents = get_room_extents(roomLookup.get_children().back())
#	var new_pos = Vector2(0, extents[0].y - get_room_height(roomLookup.get_children().back()))
#	print("adding room to %s" % new_pos)
#	new_room.position = new_pos
#	current_room = new_room
#	roomLookup.add_child(new_room)
#	fill_room(10)
#
#func remove_room(room):
#	room.queue_free()
#
#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		add_room()
#
#func get_room_on_position(pos):
#	for room in roomLookup.get_children():
#		var extents = get_room_extents(room)
#		if pos.x > extents[0].x && pos.y > extents[0].y && pos.y < extents[1].y && pos.y < extents[1].y:
#			return room
#	return null
#
