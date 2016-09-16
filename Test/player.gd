extends KinematicBody
var view_sensitivity = 0.3
var yaw = 0
var pitch = 0

func _input(ie):
	pass
	
func _fixed_process(delta):
	pass
	
func _ready():
	set_fixed_process(true)
	set_process_input(true)