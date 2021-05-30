extends Camera2D

export(float, 0.0, 10.0) var zoom_duration = 1.0

var limit_smoothie = 1
var target
var prev_limits

func zoom_in():
	var tween = Tween.new()
	tween.interpolate_property(self, "zoom",
		Vector2(1, 1), Vector2(0.135, 0.135), zoom_duration,
		Tween.TRANS_LINEAR)
	add_child(tween)
	tween.start()
	var target_pos = (get_camera_position() - get_camera_screen_center()) / 2
	var tween2 = Tween.new()
	tween2.interpolate_property(self, "offset",
		Vector2(0, 0), target_pos + Vector2(0, -21), zoom_duration,
		Tween.TRANS_LINEAR)
	add_child(tween2)
	tween2.start()
	return tween2

func zoom_out():
	var tween = Tween.new()
	tween.interpolate_property(self, "zoom",
		Vector2(0.13, 0.13), Vector2(1, 1), zoom_duration,
		Tween.TRANS_LINEAR)
	add_child(tween)
	tween.start()
	var tween2 = Tween.new()
	tween2.interpolate_property(self, "offset",
		offset, Vector2(0, 0), zoom_duration,
		Tween.TRANS_LINEAR)
	add_child(tween2)
	tween2.start()
	return tween2

func set_new_limits(limits):
#	set_limits([Vector2(-1000, -1000), Vector2(1000, 1000)])
	prev_limits = get_limits()
#	target = limits
#	var tween = Tween.new()
#	tween.interpolate_method(self, "smooth_limits",
#	1, 0, 1)
#	add_child(tween)
#	tween.start()
#	yield(tween, "tween_completed")
	set_limits(limits)
	pass

func smooth_limits(val):
	print(limit_left, target[0].x, prev_limits[0].x)
	limit_left = target[0].x + (prev_limits[0].x - target[0].x) * val
	limit_top = target[0].y + (prev_limits[0].y - target[0].y) * val
	limit_right = target[1].x + (prev_limits[1].x - target[1].x) * val
	limit_bottom = target[1].y + (prev_limits[1].y - target[1].y) * val

func get_limits():
	return [Vector2(limit_left, limit_top), Vector2(limit_right, limit_bottom)]

func set_limits(limits):
	limit_left = limits[0].x
	limit_top = limits[0].y
	limit_right = limits[1].x
	limit_bottom = limits[1].y
