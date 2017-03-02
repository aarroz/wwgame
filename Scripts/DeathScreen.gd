extends VBoxContainer

var global = "/root/global"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_MenuButton_pressed():
	pass # replace with function body
	get_node(global).setScene("res://Scenes/Menu.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
