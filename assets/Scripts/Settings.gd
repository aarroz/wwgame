extends Control

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


#func _on_OptionButton_item_selected( ID ):
#	OptionButton.get_selected_id()
#	if OptionButton.get_item_id(-1):
#		VisualServer.viewport_set_msaa(0)
#	if OptionButton._select_int(0):
#		VisualServer.viewport_set_msaa(1)
#	if OptionButton._select_int(1):
#		VisualServer.viewport_set_msaa(2)
#	if OptionButton._select_int(2):
#		VisualServer.viewport_set_msaa(3)
#	if OptionButton._select_int(3):
#		VisualServer.viewport_set_msaa(4)


#func _on_BloomButton_toggled( button_pressed ):
#	if Environment.is_glow_enabled():
#		Environment.set_glow_enabled(false)
#	else:
#		Environment.set_glow_enabled(true)


#func _on_SSRButton_toggled( button_pressed ):
#	if Environment.is_ssao_enabled():
#		Environment.set_ssao_enabled(false)
#	else:
#		Environment.set_ssao_enabled(true)
