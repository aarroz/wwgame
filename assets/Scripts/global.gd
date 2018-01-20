extends Node

var currentScene = null

var PlayerName = "Player"

func getPlayerName():
	return PlayerName

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1 )

func setScene(scene):
	currentScene.queue_free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)