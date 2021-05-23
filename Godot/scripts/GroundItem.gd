extends Area2D

export var id = ""

var show_hover = false

signal despawn(item)

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var despawnTimer = $DespawnTimer

func _ready():
	var texture = get_texture()
	if texture != null:
		sprite.texture = texture
	despawnTimer.start()

func _process(delta):
	show_hover = false
	if get_player() != null:
		show_hover = true
	set_hover_shader(show_hover)
	
func set_hover_shader(enabled):
	sprite.get_material().set_shader_param("outline_enabled", enabled)

func get_player():
	for body in get_overlapping_bodies():
		if body.name == "Player":
			return body
	return null

func blink():
	animationPlayer.play("Blink")
	
func get_texture():
	return load("res://assets/sprites/ground_items/Ground" + id + ".png")

func _on_despawnTimer_timeout():
	emit_signal("despawn", self)
