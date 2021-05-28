extends Node2D

onready var monster = $Monster

func set_monster(warning):
	var texture = load("res://assets/sprites/warning_" + warning + ".png")
	monster.texture = texture
