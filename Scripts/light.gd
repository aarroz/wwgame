extends Light

func _input(event):
	if Input.is_key_pressed(KEY_F):
		is_enabled(false)