extends StaticBody2D

onready var closed = $DoorSprite
onready var open = $DoorTop
onready var collision = $DoorCollision

func _ready():
	close_door()

func open_door():
	closed.visible = false
	open.visible = true
	collision.disabled = true

func close_door():
	closed.visible = true
	open.visible = false
	collision.disabled = false
