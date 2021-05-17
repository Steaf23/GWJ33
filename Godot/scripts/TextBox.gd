extends Control

export(String, FILE, "*.json") var dialogue

var current_line = 0
var cont = false

onready var tree
onready var name_field = $Name
onready var text_field = $Text

func _ready():
	tree = load_json()

func _process(delta):
	if cont:
		cont = false
		yield(next_line(), "completed")

func load_json():
	var file = File.new()
	file.open(dialogue, File.READ)
	var content = parse_json(file.get_as_text())
	file.close()
	return content

func _input(event):
	if event.is_action_pressed("ui_accept"):
		cont = true

func next_line():
	if current_line >= tree.size():
		queue_free()
		return
		
	name_field.text = tree[current_line][0]
	text_field.text = ""
	var text_count = 0
	var draw_speed = tree[current_line][2] if tree[current_line].size() >= 3 else 1
	
	while text_count < tree[current_line][1].length():
		text_field.text += tree[current_line][1].substr(text_count, draw_speed)
		text_count += draw_speed
		yield(get_tree(), "idle_frame")
	print(text_field)
	current_line += 1
