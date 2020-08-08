extends Control

onready var fullscreen_button = $Fullscreen/Fullscreen_button

func _ready():
	pass


func _on_Back_pressed():
	hide()


func _on_VSync_button_toggled(_button_pressed):
	if OS.is_vsync_enabled():
		OS.set_use_vsync(false)
	else:
		OS.set_use_vsync(true)


func _on_Fullscreen_button_toggled(_button_pressed):
	if OS.is_window_fullscreen() == true:
		OS.set_window_fullscreen(false)
		#fullscreen_button.pressed(true)

	elif OS.is_window_fullscreen() == false:
		OS.set_window_fullscreen(true)
		#fullscreen_button.pressed(false)
