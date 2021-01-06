extends Spatial

onready var action = $AnimationPlayer

func _ready():
	action.stop()

func door_open():
	action.play("door_open")

func door_close():
	action.play_backwards("door_open")
