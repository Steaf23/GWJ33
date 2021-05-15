class_name Player extends KinematicBody2D

export var speed = 200

var movedir = Vector2.ZERO

func _process(delta):
	var new_movedir = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		new_movedir += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		new_movedir += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		new_movedir += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		new_movedir += Vector2.DOWN
	
	move_and_collide(new_movedir * speed * delta)
#
#func _unhandled_key_input(event):
#	var new_movedir = Vector2.ZERO
#	if event.is_action_pressed("ui_left"):
#		new_movedir += Vector2.LEFT
#	if event.is_action_pressed("ui_right"):
#		new_movedir += Vector2.RIGHT
#	if event.is_action_pressed("ui_up"):
#		new_movedir += Vector2.UP
#	if event.is_action_pressed("ui_down"):
#		new_movedir += Vector2.DOWN
#	movedir = new_movedir.normalized()
	
	
