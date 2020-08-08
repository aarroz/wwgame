extends Node

var global = "/root/global"


func _on_Play_pressed():
	get_node(global).setScene("res://assets/scenes/level_intro_prototype.tscn")
	#get_node(global).setScene("res://assets/Scenes/level1.tscn")

func _on_Settings_pressed():
	get_node("Settings").show()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Back_pressed():
	get_node("Settings").hide()
