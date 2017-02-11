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
	print("BUTTONS") # replace with function body
	get_node(global).setScene("res://main.tscn")

func _on_MenuButton1_pressed():
	get_node(global).setScene("res://Scenes/Level 3/Level 3.scn") # replace with function body

func _on_MenuButton2_pressed():
	get_tree().quit() # replace with function body


