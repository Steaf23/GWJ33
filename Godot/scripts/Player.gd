extends KinematicBody2D

export var speed = 10000

signal request_pickup()

onready var camera = $Camera2D
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

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
	
	animationTree.set("parameters/Idle/blend_position", new_movedir)
	animationTree.set("parameters/Move/blend_position", new_movedir)
	
	if new_movedir != Vector2.ZERO:
		animationState.travel("Move")
	else:
		animationState.travel("Idle")
		
	move_and_slide(new_movedir * speed * delta)

func _unhandled_key_input(event):
	if event.is_action_pressed("pickup_item"):
		emit_signal("request_pickup")
	
	
