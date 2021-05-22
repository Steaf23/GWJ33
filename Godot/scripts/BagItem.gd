extends Area2D

export var id = ""

var picked_up
var mouse_offset = Vector2.ZERO
var rot : int
var old_pos = Position2D.new()
var revalidate_collision = false

signal clicked_on(item)
signal equip(item, slot)

onready var sprite = $Sprite
onready var collision = $Collision

func _ready():
	connect("clicked_on", get_parent(), "on_bagItem_clicked")
	connect("equip", get_parent(), "on_item_equip")

func _physics_process(delta):
	if revalidate_collision:
		revalidate_collision = false
	is_valid_position()

func _on_pickup():
	picked_up = true
	
func _on_dropped():
	picked_up = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				mouse_offset = get_local_mouse_position()
				picked_up = true
				old_pos.position = position
				old_pos.rotation_degrees = rot
				sprite.get_material().set_shader_param("enabled", false)
				emit_signal("clicked_on", self)

func set_rot(degrees):
	rot = degrees
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot

func rotateCW():
	set_rot(rot + 90 % 360)

func drop():
	var areas = self.get_overlapping_areas()
	if areas.size() > 0:
		if areas.size() == 1:
			if areas[0].name == "Border":
				return
		elif areas.size() > 1:
			for area in areas:
				if area.get_parent().name == "HeroEquipment":
					if area.has_mouse:
						emit_signal("equip", self, area)
						
		position = old_pos.position
		set_rot(old_pos.rotation_degrees)
		revalidate_collision = true

func update_position(new_pos):
	position = new_pos
	revalidate_collision = true

func is_valid_position():
	if self.get_overlapping_areas().size() > 0:
		sprite.get_material().set_shader_param("enabled", true)
		return true
	else:
		sprite.get_material().set_shader_param("enabled", false)
		return false
		
