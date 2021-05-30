extends Node2D

onready var monster = $Monster
onready var timer = $Timer
onready var score = $Score

onready var show_timer = true
onready var toggled = false

func set_monster(warning):
	var texture = load("res://assets/sprites/warning_" + warning + ".png")
	monster.texture = texture
	score.visible = false

func _process(delta):
	timer.text = str(Score.room_time).pad_zeros(2)
	score.text = "ROOM: " + str(Score.room_score).pad_zeros(2)
	
	var time = Score.room_time
	if time  == 0:
		show_timer = false
	elif time % 5 == 0:
		if !toggled:
			toggled = true
			monster.visible = !monster.visible
			timer.visible = !timer.visible
			score.visible = !score.visible
	elif time % 4 == 0:
		toggled = false
