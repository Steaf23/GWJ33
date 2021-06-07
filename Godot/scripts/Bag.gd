extends TileMap

const GRID_SIZE = 32
const MAX_HP = 3
var current_hp = 3
var losing = false

var held_item
var is_open = false

#signal hero_died()
signal close(items)

onready var spawns = [$Left.position, $Right.position, $Top.position]
onready var heroEquipment = $HeroEquipment
onready var frames = $HeroEquipment/Potion/AnimatedSprite
onready var items = $Items

#func _ready():
#	frames.frame = current_hp
#
#func _process(delta):
#	if current_hp <= 0:
#		emit_signal("hero_died")

func _input(event):
	if event is InputEventMouseMotion:
		if held_item != null:
			var new_pos =  (get_global_mouse_position() - held_item.mouse_offset).snapped(Vector2(GRID_SIZE, GRID_SIZE))
			held_item.position = new_pos
	if event is InputEventMouseButton:
		if event.button_index == 1:
			# if let loose of the lmb;
			if !event.is_pressed():
				if held_item != null:
					held_item.picked_up = false
					held_item.drop()
					held_item.position = held_item.position.snapped(Vector2(GRID_SIZE, GRID_SIZE))
					held_item = null
		elif event.button_index == 2:
			if !event.is_pressed():
				if held_item != null:
					held_item.rotateCW()

	if event is InputEventKey:
		# close & cleanup bag
		if (event.is_action_pressed("Open bag") || event.is_action_pressed("Interact")) && is_open:
			get_tree().set_input_as_handled()
			var drop_items = get_drop_items()
			if held_item != null:
				held_item = null
			emit_signal("close", drop_items)

func on_bagItem_clicked(item):
	held_item = item

func add(item_id):
	var bag_item = ItemConverter.create_bag_item(item_id)
	bag_item.position = get_random_spawnpoint()
	items.add_child(bag_item)
	bag_item.connect("clicked_on", self, "on_bagItem_clicked")
	bag_item.connect("equip", self, "on_item_equip")

func get_random_spawnpoint():
	return spawns[0]

func get_drop_items():
	var item_list = []
	for item in get_items():
		if item is Area2D && item.name != "Border":
			if item.should_drop:
				item_list.append(item.id)
				item.queue_free()
	return item_list

func on_item_equip(bag_item, slot):
	var remainder = heroEquipment.equip(bag_item, slot)
	if remainder != null:
		add(remainder.id)

func on_unequip_item(item):
	add(item.id)
	heroEquipment.evaluate_equipment(Score.warning)

func set_hp(hp):
	match hp:
		-1:
			hp = 0
		4:
			hp = 3
	current_hp = hp
	frames.frame = current_hp
	print("CURRENT HP: %d/%d"% [current_hp, MAX_HP])

func on_use_potion(potion):
	if current_hp < MAX_HP:
		$PotionSound.play()
		set_hp(current_hp + 1)
	else:
		add(potion.id)

func on_equip_evaluate(total):
	if randi() % 100 <= total:
		print("WIN")
		losing = false
	else:
		print("LOSE")
		losing = true
	print(int(total))

func show_equipment(show_success):
	if heroEquipment.get_parent() == null:
		add_child(heroEquipment)
		heroEquipment.eval_success = show_success
		heroEquipment.evaluate_equipment()

func hide_equipment():
	if heroEquipment.get_parent() != null:
		remove_child(heroEquipment)

func get_items():
	return items.get_children()
