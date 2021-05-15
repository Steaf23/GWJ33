extends Area2D

export(PackedScene) var ground_item

var picked_up
var mouse_offset = Vector2.ZERO
var old_pos

signal clicked_on(item)

func _ready():
	connect("clicked_on", get_parent(), "_on_ItemBlock_clicked_on")

func _on_pickup():
	picked_up = true
	
func _on_dropped():
	picked_up = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				mouse_offset = get_local_mouse_position()
				picked_up = true
				old_pos = position
				emit_signal("clicked_on", self)

func drop():
	if self.get_overlapping_areas().size() != 0:
		position = old_pos

func get_ground_item():
	return ground_item.instance()
