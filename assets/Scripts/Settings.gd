extends Control

func _ready():
	pass


func _on_Back_pressed():
	hide()


func _on_VSync_button_toggled( button_pressed ):
	if OS.is_vsync_enabled():
		OS.set_use_vsync(false)
	else:
		OS.set_use_vsync(true)


func _on_Fullscreen_button_toggled(button_pressed):
	if OS.is_window_fullscreen():
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)
