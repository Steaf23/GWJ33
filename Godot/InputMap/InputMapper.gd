extends Node

func change_action_key(action_name, keycode):
	remove_action_events(action_name)
	
	var event = InputEventKey.new()
	event.set_scancode(keycode)
	KeyActions.actions[action_name] = keycode
	InputMap.action_add_event(action_name, event)
	
func remove_action_events(action_name):
	for event in InputMap.get_action_list(action_name):
		InputMap.action_erase_event(action_name, event)
