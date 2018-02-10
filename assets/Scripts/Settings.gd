extends Panel

onready var aliasing = get_node("Anti-Aliasing/OptionButton")
onready var ssao = get_node("SSAO/OptionButton")
onready var anistropic = get_node("Anistropic Filter/OptionButton")

func _ready():
	pass


func _on_Back_pressed():
	hide()
