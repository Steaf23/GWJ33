extends Node2D

const SLOT_TYPES = ["head", "weapon", "weapon", "potion", "necklace", "body", "boots"]
const MAX_SCORE = 7 * 6

var starter_bonus = 5
var bonus_falloff = 1
var eval_success = true

onready var slots
onready var score = $Score

func _ready():
	slots = [$Head, $Weapon, $Weapon2, $Potion, $Necklace, $Body, $Boots]
	for slot in slots:
		slot.connect("unequip_item", get_parent(), "on_unequip_item")
	slots[3].connect("use_potion", get_parent(), "on_use_potion")
	score.text = ""

func evaluate_equipment(enemy_id="default"):
	var total = starter_bonus - min(bonus_falloff * Score.room_score, starter_bonus)
	for slot in slots:
		total += ItemLookup.get_success_rate(slot.item_id, enemy_id)
	var percentage = total * 100 / MAX_SCORE
	
	score.text = "Success: %d%%" % int(percentage) if eval_success else ""
	return total

func equip(bag_item, slot):
	# get the slot clicked on
	var remainder = slots[slots.find(slot)].equip(ItemConverter.to_ground(bag_item))
	match remainder:
		# if successful without remainder
		"":
			bag_item.queue_free()
			evaluate_equipment(Score.warning)
		# if not sucessful
		"fail":
			pass	
		_:
			remainder = ItemConverter.create_bag_item(remainder)
			bag_item.queue_free()
			evaluate_equipment(Score.warning)
	
	if !(remainder is String):
		return remainder
	return null
	
