extends TileMap

const GRID_SIZE = 32
const MAX_HP = 3
var current_hp = 1

var held_item

signal hero_died()

onready var spawns = [$Left.position, $Right.position, $Top.position]
onready var camera = $Camera
onready var heroEquipment = $HeroEquipment

func _process(delta):
	if held_item == null:
		pass
	if current_hp <= 0:
		emit_signal("hero_died")
		
func _input(event):
	if event is InputEventMouseMotion:
		if held_item != null:
			var new_pos = (get_global_mouse_position() - held_item.mouse_offset).snapped(Vector2(GRID_SIZE, GRID_SIZE))
			held_item.update_position(new_pos)
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
		
func _on_ItemBlock_clicked_on(item):
	held_item = item


func spawn(bag_item):
	bag_item.position = get_random_spawnpoint()
	add_child(bag_item)

func get_random_spawnpoint():
	return spawns[0]
	
func close():
	var item_list = []
	for item in get_children():
		if item is Area2D && item.name != "Border":
			if item.get_overlapping_areas().size() > 0:
				item_list.append(ItemConverter.to_ground(item))
				item.queue_free()
	return item_list

func on_item_equip(bag_item, slot):
	var remainder = heroEquipment.equip(bag_item, slot)
	if remainder != null:
		spawn(remainder)

func on_unequip_item(item):
	spawn(item)

func on_use_potion(potion):
	if current_hp < MAX_HP:
		current_hp += 1
	else:
		spawn(ItemConverter.to_bag(potion))
	print("CURRENT HP: %d/%d"% [current_hp, MAX_HP])

func show_equipment():
	pass
	
func hide_equipment():
	pass
