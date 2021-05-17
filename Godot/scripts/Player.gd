extends KinematicBody2D

export var speed = 10000

signal request_pickup()

onready var camera = $Camera2D
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var automoving = false
var old_movedir = Vector2.ZERO

func _ready():
	animationTree.active = true

func _process(delta):
	
	if !automoving:
		var new_movedir = Vector2.ZERO
		if Input.is_action_pressed("ui_left"):
			new_movedir += Vector2.LEFT
		if Input.is_action_pressed("ui_right"):
			new_movedir += Vector2.RIGHT
		if Input.is_action_pressed("ui_up"):
			new_movedir += Vector2.UP
		if Input.is_action_pressed("ui_down"):
			new_movedir += Vector2.DOWN
		
#		var old_movedir = Vector2.ZERO
#		if Input.is_action_just_released("ui_left"):
#			old_movedir += Vector2.LEFT
#		if Input.is_action_just_released("ui_right"):
#			old_movedir += Vector2.RIGHT
#		if Input.is_action_just_released("ui_up"):
#			old_movedir += Vector2.UP
#		if Input.is_action_just_released("ui_down"):
#			old_movedir += Vector2.DOWN
			
		animationTree.set("parameters/Idle/blend_position", new_movedir)
		animationTree.set("parameters/Move/blend_position", new_movedir)

		if new_movedir != Vector2.ZERO:
			# set the old_movedir to new_movedir
			old_movedir = new_movedir
			animationState.travel("Move")
		else:
			set_animation(old_movedir, "Idle")
			
		move_and_slide(new_movedir * speed * delta)
			

func _unhandled_key_input(event):
	if event.is_action_pressed("pickup_item"):
		emit_signal("request_pickup")

func set_animation(facing: Vector2, animation: String):
	animationTree.set("parameters/" + animation + "/blend_position", facing)
	animationState.travel(animation)

func move_to(pos, speed):
	automoving = true
	set_animation((pos - position).normalized(), "Move")
	var tween = Tween.new()
	tween.interpolate_property(self, "position",
		position, pos, speed,
		Tween.TRANS_LINEAR)
	add_child(tween)
	tween.start()
	tween.connect("tween_completed", self, "on_automove_completed")
	return tween

func on_automove_completed(object, key):
	automoving = false
	
	
