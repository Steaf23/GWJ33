extends Node2D

var slot_types = {"head":0, 
				  "necklace":1, 
				  "weapon":2, 
				  "body":3, 
				  "boots":4,
				  "special":-1}
var slots = ["", "", "", "", ""]

onready var slotBox = $SlotBox
onready var bootsSprite = $SlotBox/Boots
onready var bodySprite = $SlotBox/Boots
onready var weaponSprite = $SlotBox/Weapon
onready var necklaceSprite = $SlotBox/Necklace
onready var headSprite = $SlotBox/Head

func evaluate_equipment(enemy_id):
	var total = 0
	for slot in slots:
		if slot != "":
			print(slot)
			total += slot[enemy_id]
	print(total)
	return total

func set_slot(idx, item_id):
	slots[idx] = item_id

func equip(item_id):
	var slot_i = slot_types[ItemLookup.get_type(item_id)]
	match slots[slot_i]:
		"special", "":
			pass
		_:
			slots[slot_i] = item_id
			
	update_equipment()
	evaluate_equipment("vampire")

func update_equipment():
	headSprite.texture = ItemConverter.create_ground_item(slots[0]).get_texture()
	necklaceSprite.texture = ItemConverter.create_ground_item(slots[1]).get_texture()
	weaponSprite.texture = ItemConverter.create_ground_item(slots[2]).get_texture()
	bodySprite.texture = ItemConverter.create_ground_item(slots[3]).get_texture()
	bootsSprite.texture = ItemConverter.create_ground_item(slots[4]).get_texture()
