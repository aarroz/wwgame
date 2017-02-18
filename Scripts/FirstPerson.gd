
extends RigidBody

# Improved Jumping and Object Interaction, thanks to Karroffel
# Values for speed, sprint, and height are in meters/second

var global = "/root/global"
# These variables set the camera rotation.
var X = 0.00
var Y = 0.00
# These variables set the speed of character movement
var speed = 3 # m/s #Player speed
var sprint = 5 #m/s
var height = 2 #m/s
# The variables below set the jump velocity and floor detection
var vel = Vector3()
var interactable = false
var JUMP_VELOCITY = 12
var jumping = false
# The onready vars below define the points of interest for the actions.
onready var ray = get_node("Camera/ray")
onready var position = get_node("Camera/playerpoint")
onready var playerfeet = get_node("playerfeet")
onready var cursor = get_node("Camera/playerpoint/cursor")

#Section of code below controls the player's movement, vars in the begining set the ground detection up for jump.
func _fixed_process(delta):
	cursor.hide()
	var is_on_ground = playerfeet.is_colliding()
	if (is_on_ground):
		jumping = false
		#print("hey, it works!")
	#Player movement
	if (Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_W)):
		translate(Vector3(0, 0, -sprint*delta))
	if Input.is_key_pressed(KEY_W):
		translate(Vector3(0, 0, -speed*delta))
	if Input.is_key_pressed(KEY_S):
		translate(Vector3(0, 0, speed*delta))
	if Input.is_key_pressed(KEY_A):
		translate(Vector3(-speed*delta, 0, 0))
	if Input.is_key_pressed(KEY_D):
		translate(Vector3(speed*delta, 0, 0))
	# Section below controls the use of Jump
	if (Input.is_key_pressed(KEY_SPACE) and not jumping):
		var velocity = get_linear_velocity()
		velocity.y = JUMP_VELOCITY
		set_linear_velocity(velocity)
		jumping = true

	# This section below controls the object interaction between the player and rigidbody with the node "moveable"
	if ray.is_colliding():
		var object = ray.get_collider()
		var visible = true
		if (object.is_in_group("moveable")):
			cursor.show()
			if (Input.is_mouse_button_pressed(1)):
				var trans = position.get_global_transform()
				object.set_global_transform(trans)
				object.set_rotation(Vector3(0,-X,0))
				object.set_linear_velocity(Vector3(0, 0, 0))
			if (Input.is_mouse_button_pressed(2)):
				object.apply_impulse(Vector3(0,0,0),Vector3(0,0,0))
				#object.set_linear_velocity((velocity - get_global_transform().origin)*10)
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
		get_node(global).setScene("res://Scenes/Menu.tscn")
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
