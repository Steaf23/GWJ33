extends Button

var action

signal button_pressed(button)

func _on_pressed():
	emit_signal("button_pressed", self)
