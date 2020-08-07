extends Spatial


onready var Play_1 = $Player
onready var Cam_1 = $Player/rotation_helper/Camera
onready var Play_2 = $Player2
onready var Cam_2 = $Player2/rotation_helper/Camera


# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Player 1 as default
	Cam_2.set_current(0)
	Cam_1.set_current(1)
	my_pause(Play_2)
	my_resume(Play_1)

func my_pause(node : Node) -> void:
	node.set_physics_process(false)
	node.set_process(false)
	node.set_process_input(false)
	# disable input processes
	# disable physics somehow

func my_resume(node : Node) -> void:
	node.set_physics_process(true)
	node.set_process(true)
	node.set_process_input(true)

func _input(event):
	if Input.is_key_pressed(KEY_1):
		Cam_2.set_current(0)
		Cam_1.set_current(1)
		my_pause(Play_2)
		my_resume(Play_1)
	if Input.is_key_pressed(KEY_2):
		Cam_1.set_current(0)
		Cam_2.set_current(1)
		my_pause(Play_1)
		my_resume(Play_2)
