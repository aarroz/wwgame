extends Spatial

var door
var detect_player

func _ready():
	door = $spawn_room/door
	detect_player = false


func _on_door_level_body_entered(body):
	if body.name == "Player":
		detect_player = true
	else:
		detect_player = false

func _on_Player_beep():
	if detect_player:
		door.set_visible(true)
