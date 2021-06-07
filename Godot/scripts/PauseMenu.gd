extends Control

var new_pause_state

func _input(event):
	if event.is_action_pressed("ui_pause"):
		new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_resume_pressed():
	visible = false
	get_tree().paused = false


func _on_keyScreen_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://InputMap/KeyRebind.tscn")
