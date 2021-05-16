extends Area2D

export(PackedScene) var ground_item
export var id = ""

var picked_up
var mouse_offset = Vector2.ZERO
var old_pos = Position2D.new()
var rot : int

signal clicked_on(item)

onready var sprite = $Sprite
onready var collision = $Collision

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
				old_pos.position = position
				old_pos.rotation_degrees = rot
				emit_signal("clicked_on", self)

# TODO change this, add old_rotation
func set_rot(degrees):
	print(degrees)
	rot = degrees
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot

func rotateCW():
	set_rot(rot + 90 % 360)

func drop():
	if self.get_overlapping_areas().size() != 0:
		position = old_pos.position
		set_rot(old_pos.rotation_degrees) 

func get_ground_item():
	return ground_item.instance()
