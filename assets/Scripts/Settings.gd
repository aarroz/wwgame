extends Panel

onready var aliasing = get_node("Anti-Aliasing/OptionButton")
onready var ssao = get_node("SSAO/OptionButton")
onready var anistropic = get_node("Anistropic Filter/OptionButton")

func _ready():
	pass


func _on_Back_pressed():
	hide()


func _on_VSync_button_toggled( button_pressed ):
	if OS.is_vsync_enabled():
		OS.set_use_vsync(false)
	else:
		OS.set_use_vsync(true)
