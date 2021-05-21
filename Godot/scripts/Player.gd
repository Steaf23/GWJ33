extends KinematicBody2D

export var speed = 10000

signal request_pickup()

onready var camera = $Camera2D
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var label = $Label

var automoving = false
var old_movedir = Vector2.ZERO
var velocity = Vector2.ZERO
var on_stair = false
var show_bag = false
var stair_multiplier = .75

func _ready():
	animationTree.active = true

func _process(delta):
	if !automoving && !show_bag:
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
			# set the old_movedir to new_movedir
			old_movedir = new_movedir
			animationState.travel("Move")
		else:
			set_animation(old_movedir, "Idle")
		
		match on_stair:
			0:
				velocity = new_movedir * speed * delta
			1:
				new_movedir = Vector2(new_movedir.x, new_movedir.y + (new_movedir.x * stair_multiplier)) * .5
			2:
				new_movedir = Vector2(new_movedir.x, new_movedir.y - (new_movedir.x * stair_multiplier)) * .5
			3:
				new_movedir.y = new_movedir.y * .5
				velocity = new_movedir * speed * delta
		velocity = new_movedir * speed * delta
		velocity = move_and_slide(velocity)
	elif show_bag:
		set_animation(Vector2.UP, "Idle")
	
	label.text = "(%d, %d) \n (%d, %d)" % [position.x, position.y, position.x / 32, position.y / 32]
			

func _unhandled_key_input(event):
	if event.is_action_pressed("pickup_item"):
		emit_signal("request_pickup")
		

func set_animation(facing: Vector2, animation: String):
	animationTree.set("parameters/" + animation + "/blend_position", facing)
	animationState.travel(animation)

func move_to(pos, duration):
	automoving = true
	if pos == position:
		set_animation(Vector2.UP, "Idle")
	else:
		set_animation((pos - position).normalized(), "Move")
	
	var tween = Tween.new()
	tween.interpolate_property(self, "position",
		position, pos, duration,
		Tween.TRANS_LINEAR)
	add_child(tween)
	tween.start()
	tween.connect("tween_completed", self, "on_automove_completed")
	return tween

func on_automove_completed(object, key):
	automoving = false
	
	
