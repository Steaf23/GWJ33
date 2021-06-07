extends Node

var master_vol = 100
var music_vol = 100
var sfx_vol = 100

func _enter_tree():
	AudioServer.set_bus_layout(load("res://resources/bus_layout.tres"))

func update_bus(bus_name, value):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), true if value == 0 else false)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear2db(value / 100))
