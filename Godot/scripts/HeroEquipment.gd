extends Node2D

const SLOT_TYPES = ["head", "weapon", "weapon", "potion", "necklace", "body", "boots"]

var starter_bonus = 10
var bonus_falloff = 2

signal evaluate(score)

onready var slots
onready var score = $Score

func _ready():
	slots = [$Head, $Weapon, $Weapon2, $Potion, $Necklace, $Body, $Boots]
	for slot in slots:
		slot.connect("unequip_item", get_parent(), "on_unequip_item")
	slots[3].connect("use_potion", get_parent(), "on_use_potion")
	connect("evaluate", get_parent(), "on_equip_evaluate")

func evaluate_equipment(enemy_id="default"):
	var total = starter_bonus - min(bonus_falloff * Score.room_score, 0)
	for slot in slots:
		total += ItemLookup.get_success_rate(slot.item_id, enemy_id)
	emit_signal("evaluate", total)
	score.text = "Success: " + str(total) + "%" 
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
	
