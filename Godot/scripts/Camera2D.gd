extends Camera2D

export(float, 0.0, 10.0) var zoom_duration = 1.0

func zoom_in():
	var tween = Tween.new()
	tween.interpolate_property(self, "zoom",
		Vector2(1, 1), Vector2(0.135, 0.135), zoom_duration,
		Tween.TRANS_LINEAR)
	add_child(tween)
	tween.start()
	return tween

func zoom_out():
	var tween = Tween.new()
	tween.interpolate_property(self, "zoom",
		Vector2(0.13, 0.13), Vector2(1, 1), zoom_duration,
		Tween.TRANS_LINEAR)
	add_child(tween)
	tween.start()
	return tween
