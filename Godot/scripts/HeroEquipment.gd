extends Node2D

const SLOT_TYPES = ["head", "weapon", "weapon", "necklace", "body", "boots"]

onready var slots

func _ready():
	slots = [$Head, $Weapon, $Weapon2, $Necklace, $Body, $Boots]
	for slot in slots:
		slot.connect("unequip_item", get_parent(), "on_unequip_item")

func evaluate_equipment(enemy_id="default"):
	var total = 0
	for slot in slots:
		total += ItemLookup.get_success_rate(slot.item_id, enemy_id)
	print("SCORE: %d" % total)
	return total

func equip(bag_item, slot):
	# get the slot clicked on
	var remainder = slots[slots.find(slot)].equip(ItemConverter.to_ground(bag_item))
	
	match remainder:
		# if successful without remainder
		"":
			bag_item.queue_free()
			evaluate_equipment()
		# if not sucessful
		"fail":
			pass	
		_:
			remainder = ItemConverter.create_bag_item(remainder)
			bag_item.queue_free()
			evaluate_equipment()
	
	if !(remainder is String):
		return remainder
	return null
	
