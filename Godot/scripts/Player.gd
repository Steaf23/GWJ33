extends KinematicBody2D

export var speed = 10000

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var camera = $Camera

var automoving = false
var old_movedir = Vector2.ZERO
var velocity = Vector2.ZERO
var show_bag = false
var freeze = false
var on_stair = 0
var stair_multiplier = .75

func _ready():
	animationTree.active = true

func _process(delta):
	if !automoving && !show_bag && !freeze:
		var new_movedir = Vector2.ZERO
		if Input.is_action_pressed("Move left"):
			new_movedir += Vector2.LEFT
		if Input.is_action_pressed("Move right"):
			new_movedir += Vector2.RIGHT
		if Input.is_action_pressed("Move up"):
			new_movedir += Vector2.UP
		if Input.is_action_pressed("Move down"):
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
			1:
				new_movedir = Vector2(new_movedir.x, new_movedir.y + (new_movedir.x * stair_multiplier)) * .5
			2:
				new_movedir = Vector2(new_movedir.x, new_movedir.y - (new_movedir.x * stair_multiplier)) * .5
			3:
				new_movedir.y = new_movedir.y * .5

		velocity = new_movedir * speed * delta
		velocity = move_and_slide(velocity)
	elif show_bag:
		set_animation(Vector2.UP, "Idle")			

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
	
	
