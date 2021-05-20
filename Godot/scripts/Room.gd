extends Node2D

enum {BRICKS=0, CLOSED_DOOR=1, OPEN_DOOR=2, STAIR_LEFT=3, STAIR_RIGHT=4, STAIR_TOP=5}

var door_location = Vector2.ZERO

onready var groundLayer = $Ground
onready var wallLayer = $Wall
onready var layers = [groundLayer, wallLayer]
onready var limits

func _ready():
#	limits.set_room_extents(groundLayer, wallLayer)
#	remove_child(wallLayer)
#	remove_child(groundLayer)
#	get_parent().call_deferred("add_child", wallLayer)
#	get_parent().call_deferred("add_child", groundLayer)
#	generate_items(10)
	pass

func get_as_room_holder():
	var holder = {"ground":groundLayer, 
				  "wall":wallLayer,
				  "limits":limits,
				  "door":door_location}
	remove_child(wallLayer)
	remove_child(groundLayer)
	return holder

#func close_door():
#	for cell in wallLayer.get_used_cells_by_id(OPEN_DOOR):
#		wallLayer.set_cellv(cell, CLOSED_DOOR)
#
#func open_door():
#	for cell in wallLayer.get_used_cells_by_id(CLOSED_DOOR):
#		wallLayer.set_cellv(cell, OPEN_DOOR)
#
func apply_slope_transform(player, movedir):
	var player_pos = to_local(player.position)
	match groundLayer.get_cellv(groundLayer.world_to_map(player_pos)):
		STAIR_LEFT:
			player.on_stair = 1
		STAIR_RIGHT:
			player.on_stair = 2
		STAIR_TOP:
			player.on_stair = 3
		_:
			player.on_stair = 0
