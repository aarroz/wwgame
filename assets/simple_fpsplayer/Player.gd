extends KinematicBody
#Variables
var global = "root/global"

#This sets the variables for the fake physics.
const GRAVITY = -32.8
var vel = Vector3()
const MAX_SPEED = 10
const JUMP_SPEED = 12
const ACCEL = 4.5

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper
var ray
var position

var MOUSE_SENSITIVITY = 0.05

const MAX_SPRINT_SPEED = 20
const SPRINT_ACCEL = 18
var is_sprinting = false

var flashlight
var icon_move

# This set's our signal to call interactable nodes in the scene.
signal beep

func _ready():
	# Defines our variables
	camera = $rotation_helper/Camera
	rotation_helper = $rotation_helper
	flashlight = $rotation_helper/Flashlight
	ray = $rotation_helper/Camera/rayarm
	icon_move = $rotation_helper/Camera/interact_moveable
	position = $rotation_helper/Camera/point
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)


func process_input(delta):
	# Processes how the character walks
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()
	# Everytime we press an action. The movement vector changes by 1 on it's respective axis.
	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	dir += -cam_xform.basis.z.normalized() * input_movement_vector.y
	dir += cam_xform.basis.x.normalized() * input_movement_vector.x

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = JUMP_SPEED

	# ----------------------------------
	# Capturing/Freeing the cursor (Used for debugging)
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------

# ----------------------------------
# Turning the flashlight on/off
	if Input.is_action_just_pressed("flashlight"):
		if flashlight.is_visible_in_tree():
			flashlight.hide()
		else:
			flashlight.show()

func _process(delta):
# Interaction method. It checks to see if raycast collides with a "moveable" physics prop and holds it where the transform's coordinates are.
# Is this the best way to do this? Of course not. But this breaks everytime I try to improve it, so I don't change it anymore.
	if ray.is_colliding():
		var object = $rotation_helper/Camera/rayarm.get_collider()
		if object.is_in_group("moveable"):
			icon_move.show()
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				var trans = position.get_global_transform()
				object.set_global_transform(trans)
				object.set_linear_velocity(Vector3(0, 0, 0))
	else:
		icon_move.hide()
	

# Processes the movement using the physics variables we have set.
func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE), false)

# Processes camera movement, interact with buttons, and quitting to menu
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -85, 85)
		rotation_helper.rotation_degrees = camera_rot
	
	# Calling interact on interactable
	if Input.is_key_pressed(KEY_E):
		emit_signal("beep")
	
	# Returns to menu
	if Input.is_key_pressed(KEY_Q):
		get_node("/root/global").setScene("res://assets/mainmenu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
