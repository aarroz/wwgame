
extends RigidBody

# Improved Jumping and Object Interaction, thanks to Karroffel

var X = 0.00
var Y = 0.00
var speed = 0.05 #Player speed
var sprint = 0.08
var height = 0.1
var vel = Vector3()
var interactable = false
var JUMP_VELOCITY = 5
var jumping = false
onready var ray = get_node("Camera/ray")
onready var position = get_node("Camera/playerpoint")
onready var playerfeet = get_node("playerfeet")

func _fixed_process(delta):
	var is_on_ground = playerfeet.is_colliding()
	if (is_on_ground):
		jumping = false
		print("hey, it works!")
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
	if (Input.is_key_pressed(KEY_SPACE) and not jumping):
		var velocity = get_linear_velocity()
		velocity.y = JUMP_VELOCITY
		set_linear_velocity(velocity)
		jumping = true

	
	if ray.is_colliding():
		var object = ray.get_collider()
		if (object.is_in_group("moveable")):
			print("hi")
			#object.set_translation(ray.get_cast_to())
		if (object.is_in_group("moveable") and Input.is_mouse_button_pressed(1)):
			#print("grab")
			var trans = position.get_global_transform()
			object.set_global_transform(trans)
			object.set_linear_velocity(Vector3(0, 0, 0))

#note somebody will find. Expression = value. Statement != value.
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
		
	if Input.is_key_pressed(KEY_G):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#Quit Function
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()
			
func _ready():
	#Hide and capture mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_fixed_process(true)
	set_process_input(true)