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
		next_line()

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
	name_field.text = tree[current_line][0]
	text_field.text = tree[current_line][1]
	print(text_field)
	current_line += 1
