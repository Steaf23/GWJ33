extends Node2D

onready var window_size = get_viewport_rect().size
onready var following = get_parent()
onready var player_world_pos = get_player_grid_pos()

func _ready():
	var canvas_transform  = get_viewport().canvas_transform
	canvas_transform[2] = player_world_pos * window_size
	get_viewport().canvas_transform = canvas_transform
	
func get_player_grid_pos():
	var pos = following.position
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.x)
	return Vector2(x, y)

func _process(delta):
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Transform2D()
	
	transform = get_canvas_transform()
	transform[2] = -following.position * window_size
	get_viewport().set_canvas_transform(transform)
	
	return transform
