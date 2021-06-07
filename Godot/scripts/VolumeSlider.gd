extends HBoxContainer

export(String) var bus = ""

onready var label = $Label
onready var slider = $Slider
onready var testSound = $TestSound

func _ready():
	update_slider(slider.value)
	testSound.bus = bus

func update_slider(value):
	label.text = "%s: %s%%" % [bus.capitalize(), value] 
	Volume.update_bus(bus, value)
	testSound.play()


func _on_value_changed(value):
	update_slider(value)
