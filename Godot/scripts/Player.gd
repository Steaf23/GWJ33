extends KinematicBody2D

export var speed = 200

signal request_pickup()

func _ready():
	connect("request_pickup", get_parent(), "on_player_request_pickup")

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

func _unhandled_key_input(event):
	if event.is_action_pressed("pickup_item"):
		emit_signal("request_pickup")
	
	
