extends Area2D

export var id = ""
export(AudioStreamSample) var pickup_sound = load("res://assets/sounds/SFX/WAV/New SFX (WAV) - Item Pick-Up.wav")

var picked_up
var mouse_offset = Vector2.ZERO
var rot : int
var old_pos = Position2D.new()

signal clicked_on(item)
signal equip(item, slot)

onready var sprite = $Sprite
onready var collision = $Collision
onready var moveSound = $MoveSound
onready var pickupSound = $PickupSound

onready var overlapping_areas = []
onready var should_drop = false

func _ready():
	pickupSound.stream = pickup_sound
	pickupSound.play()

func _physics_process(delta):
	get_overlapping_area()

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
				moveSound.play()
				old_pos.position = position
				old_pos.rotation_degrees = rot
				emit_signal("clicked_on", self)

func set_rot(degrees):
	moveSound.play()
	rot = degrees
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot

func rotateCW():
	set_rot(rot + 90 % 360)

func drop():
	print(overlapping_areas)
	var area = get_overlapping_area()
	if area != null:
		# Area == equipment slot
		if area.get_parent().name == "HeroEquipment":
			emit_signal("equip", self, area)
			return
		# Area == Other Item
		elif area.is_in_group("bag_items"):
			position = old_pos.position
			set_rot(old_pos.rotation_degrees)
			return
		# Area == border	
		elif area.name == "Border":
			return
		
# gets overlapping area based on priority equipmentslot - item - border
func get_overlapping_area():
	if overlapping_areas.size() <= 0:
		sprite.get_material().set_shader_param("enabled", false)
		should_drop = false
		return null
	else:
		for area in overlapping_areas:
			# Area == equipment slot
			if area.get_parent().name == "HeroEquipment":
				sprite.get_material().set_shader_param("enabled", true)
				return area
				
		for area in overlapping_areas:
			# Area == Other Item
			if area.is_in_group("bag_items"):
				sprite.get_material().set_shader_param("enabled", true)
				should_drop = true
				return area
				
		for area in overlapping_areas:
			# Area == Other Item
			if area.name == "Border":
				sprite.get_material().set_shader_param("enabled", true)
				should_drop = true
				return area
	return null

func _on_object_area_entered(area):
	overlapping_areas.append(area)

func _on_object_area_exited(area):
	overlapping_areas.erase(area)
