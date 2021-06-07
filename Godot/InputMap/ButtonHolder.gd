extends GridContainer

onready var buttonPreload = preload("res://InputMap/RebindButton.tscn")

func add_button(action, keycode):
	var button = buttonPreload.instance() 
	add_child(button)
	button.action = [action, keycode]
	update_button(button, keycode)
	return button

func update_button(button, keycode):
	var key_string = PoolByteArray([keycode]).get_string_from_utf8()
	if key_string == " ":
		key_string = "SPACE"
	button.text = "%s: [%s]" % [button.action[0], key_string]
	button.action = [button.action[0], keycode]
