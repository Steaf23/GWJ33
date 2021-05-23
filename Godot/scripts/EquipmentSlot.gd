extends Node2D

export(String) var type = ""
export(Texture) var default_texture 

var item_id: String = ""
var has_mouse = false

signal unequip_item(item)
signal use_potion(potion)

onready var icon = $Icon
onready var collision = $Collision

func _ready():
	icon.texture = default_texture 

# 3 states, equip successful, equip successful + remainder, equip unsuccessful
func equip(item):
	if ItemLookup.item_data[item.id]['type'] == type:
		if type == "potion":
			emit_signal("use_potion", item)
			return ""
		var old_item = item_id
		item_id = item.id
		icon.offset = Vector2(0, -8)
		icon.texture = item.get_texture()
		return old_item
	return "fail"
	
func unequip():
	icon.offset = Vector2(0, 0)
	icon.texture = default_texture
	var bag_item = ItemConverter.create_bag_item(item_id)
	item_id = ""
	return bag_item

func set_item(ground_item):
	item_id = ground_item.id
	icon.texture = ground_item.get_texture()

func _on_mouse_entered():
	has_mouse = true

func _on_mouse_exited():
	has_mouse = false

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_select"):
		if item_id != "":
			emit_signal("unequip_item", unequip())
