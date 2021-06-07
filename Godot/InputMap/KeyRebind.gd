extends Control

onready var selectPopup = $KeySelectPopup
onready var buttonHolder = $VBoxContainer/ButtonHolder
onready var inputMapper = $InputMapper

func _ready():
	for action in KeyActions.actions.keys():
		var button = buttonHolder.add_button(action, KeyActions.actions[action])
		button.connect("button_pressed", self, "on_rebind_button_pressed")
		if !InputMap.has_action(action):
			InputMap.add_action(action)

func on_rebind_button_pressed(button):
	set_process_input(false)
	
	selectPopup.open()
	var keycode = yield(selectPopup, "key_selected")
	inputMapper.change_action_key(button.action[0], keycode)
	buttonHolder.update_button(button, keycode)
	
	
	set_process_input(true)


func _on_DoneButton_pressed():
	get_tree().change_scene("res://scenes/World.tscn")
