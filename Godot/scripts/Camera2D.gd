extends Camera2D

export(float, 0.0, 10.0) var zoom_duration = 1.0

func zoom_in(player_pos):
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
	return tween

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
	return tween

func set_new_limits(limits):
	pass
#	limit_left = limits[0].x
#	limit_top = limits[0].y
#	limit_right = limits[1].x
#	limit_bottom = limits[1].y
