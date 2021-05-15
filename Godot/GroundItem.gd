extends Area2D

signal item_clicked(item)

var id = "generic_item"
var show_hover = false

onready var sprite = $Sprite

func _process(delta):
	show_hover = false
	for body in get_overlapping_bodies():
		if body is Player:
			show_hover = true
			break
	set_hover_shader(show_hover)

#func _on_input_event(viewport, event, shape_idx):
#	var pressed
#	if event is InputEventMouseButton:
#		if event.button_index == 1:
#			if event.is_pressed():
#				emit_signal("item_clicked", self)

func _on_mouse_entered():
	show_hover = true

func _on_mouse_exited():
	show_hover = false
	
func set_hover_shader(enabled):
	sprite.get_material().set_shader_param("enabled", enabled)

