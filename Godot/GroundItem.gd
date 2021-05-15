extends Area2D

signal item_clicked(item)

var id = "generic_item"
var show_hover = false

func _on_input_event(viewport, event, shape_idx):
	var pressed
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				emit_signal("item_clicked", self)
	elif event is InputEventMouseMotion:
		show_hover = true
	else:
		show_hover = false
