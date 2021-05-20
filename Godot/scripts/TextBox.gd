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
		name_field.text = ""
		text_field.text = ""
		cont = true
		get_tree().set_input_as_handled()

func next_line():
	if current_line >= tree.size():
		yield(get_tree(), "idle_frame")
		queue_free()
		return
		
	name_field.text = tree[current_line][0]
	text_field.text = ""
	var text_count = 0
	var draw_speed = 1 # tree[current_line][2] if tree[current_line].size() >= 3 else 1
	var slowdown = tree[current_line][2] if tree[current_line].size() >= 3 else 1
	var tween = Tween.new()
	
	var i = 0
	while text_count < tree[current_line][1].length():
		if cont: 
			break
		if i % int(slowdown) == 0: 
			text_field.text += tree[current_line][1].substr(text_count, draw_speed)
			text_count += draw_speed
		i += 1
		yield(get_tree(), "idle_frame")
	current_line += 1
