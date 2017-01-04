
extends RigidBody

var X = 0.00
var Y = 0.00
var speed = 0.05 #Player speed
var sprint = 0.08
var height = 0.1
const JUMP_SPEED = 2
var on_floor = false
var vel = Vector3()

func _fixed_process(delta):
	#Player movement
	if (Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_W)):
		translate(Vector3(0, 0, -sprint))
	if Input.is_key_pressed(KEY_W):
		translate(Vector3(0, 0, -speed))
	if Input.is_key_pressed(KEY_S):
		translate(Vector3(0, 0, speed))
	if Input.is_key_pressed(KEY_A):
		translate(Vector3(-speed, 0, 0))
	if Input.is_key_pressed(KEY_D):
		translate(Vector3(speed, 0, 0))
	if Input.is_key_pressed(KEY_SPACE):
		translate(Vector3(0, height, 0))
#	if (Input.is_key_pressed(KEY_SPACE)):
#		set_linear_velocity(Vector3(0, JUMP_SPEED, 0))
#	if (on_floor and Input.is_key_pressed(KEY_SPACE)):
#		vel.y = JUMP_SPEED
	#Exit Function
#	if (Input.is_key_pressed(KEY_Q))
#		

func _input(event):
	#Camera motion
	if event.type == InputEvent.MOUSE_MOTION:
		X += event.relative_x*0.005
		self.set_rotation(Vector3(0, -X, 0))
		Y += event.relative_y*0.005
		if(not Y > 1.5):
			get_node("Camera").set_rotation(Vector3(-Y,0,0))
		else:
			Y = 1.5
		if(not Y < -1.5):
			get_node("Camera").set_rotation(Vector3(-Y,0,0))
		else:
			Y = -1.5
		#Show mouse
		if Input.is_key_pressed(KEY_ESCAPE):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
func _ready():
	#Hide and capture mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_fixed_process(true)
	set_process_input(true)