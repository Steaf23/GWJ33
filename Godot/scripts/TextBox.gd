extends Control

var current_line = 0
var cont = false

signal dialogue_completed()

onready var dialogue
onready var tree
onready var name_field = $Name
onready var text_field = $Text

func _ready():
	tree = load_json(dialogue)
	name_field.text = ""
	text_field.text = ""
	cont = true

func _process(delta):
	if cont:
		cont = false
		yield(next_line(), "completed")

func load_json(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = parse_json(file.get_as_text())
	file.close()
	return content

func _input(event):
	if event.is_action_pressed("pickup_item") || event.is_action_pressed("open_bag") || event.is_action_pressed("mouse_select"):
		name_field.text = ""
		text_field.text = ""
		cont = true
		get_tree().set_input_as_handled()

func next_line():
	if current_line >= tree.size():
		yield(get_tree(), "idle_frame")
		queue_free()
		emit_signal("dialogue_completed")
		return
	
	name_field.text = tree[current_line][0]
	text_field.text = ""
	var text_count = 0
	var slowdown = tree[current_line][2] if tree[current_line].size() >= 3 else 1
	
	var i = 0
	while text_count < tree[current_line][1].length():
		if cont: 
			break
		if i % int(slowdown) == 0: 
			text_field.text += tree[current_line][1].substr(text_count, 1)
			text_count += 1
		i += 1
		yield(get_tree(), "idle_frame")
	current_line += 1
