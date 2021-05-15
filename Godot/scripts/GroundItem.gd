extends Area2D

export(PackedScene) var bag_item

var show_hover = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _process(delta):
	show_hover = false
	if get_player() != null:
		show_hover = true
	set_hover_shader(show_hover)

func _on_mouse_entered():
	show_hover = true

func _on_mouse_exited():
	show_hover = false
	
func set_hover_shader(enabled):
	sprite.get_material().set_shader_param("outline_enabled", enabled)

func get_player():
	for body in get_overlapping_bodies():
		if body.name == "Player":
			return body
	return null

func get_bag_item():
	return bag_item.instance()

func blink():
	animationPlayer.play("Blink")
