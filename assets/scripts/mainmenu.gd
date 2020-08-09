extends Node

var global = "/root/global"
onready var level_tutorial = preload("res://assets/scenes/puzzles/level_tutorial.tscn")

func _on_Play_pressed():
	#get_node("Level_Select").show()
	get_node(global).setScene("res://assets/scenes/puzzles/level_tutorial.tscn")

func _on_Settings_pressed():
	get_node("Settings").show()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Back_pressed():
	get_node("Settings").hide()


func _on_Option_1_pressed():
	get_node(global).setScene("res://assets/scenes/level1.tscn")


func _on_Option_2_pressed():
	get_node(global).setScene("res://assets/scenes/level_intro_prototype.tscn")


func _on_Option_3_pressed():
	get_node(global).setScene("res://assets/scenes/prototype_box.tscn")
