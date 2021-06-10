extends Control

func _ready():
	$Score.text = "Room: %d" % [Score.room_score]
	$AudioStreamPlayer.stream.loop_end = 108000
	$AudioStreamPlayer.play()

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/World.tscn")
