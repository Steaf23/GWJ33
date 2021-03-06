extends Area2D

var show_hover = false

onready var sprite = $Sprite
onready var collision = $Collision

func _process(delta):
	show_hover = false
	if get_player() != null:
		show_hover = true
	set_hover_shader(show_hover)

func set_hover_shader(enabled):
	sprite.get_material().set_shader_param("outline_enabled", enabled)

func get_player():
	for body in get_overlapping_bodies():
		if body.name == "Player":
			return body
	return null
