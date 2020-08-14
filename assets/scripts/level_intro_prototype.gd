extends Spatial

var door1
var door2
var door3
var door4
var level1
var level2
var level3
var level4
var door1_sound
var door2_sound
var door3_sound
var door4_sound

var script_1
var script_1_done

# For the teleport mechanic
onready var Effect_teleport = preload("res://assets/scripts/shaders/ColorRect_dissolve.tscn")
var global = "/root/global"

onready var Play_1 = $Player
onready var Cam_1 = $Player/rotation_helper/Camera
onready var Play_2 = $Player2
onready var Cam_2 = $Player2/rotation_helper/Camera

func _ready():
	# assigns Nodes to variables for the level
	door1 = $spawn_room/door
	door2 = $spawn_room/door2
	door3 = $spawn_room/door3
	door4 = $spawn_room/door4
	door1_sound = $door_level/notify
	door2_sound = $door_level2/notify2
	door3_sound = $door_level3/notify2
	door4_sound = $door_level4/notify
	level1 = false
	level2 = false
	level3 = false
	level4 = false
	script_1_done = false
	script_1 = $physics_objects/scripted_crate
	
	# Set Player 1 as default
	Cam_2.set_current(0)
	Cam_1.set_current(1)
	my_pause(Play_2)
	my_resume(Play_1)

func teleport():
	var fx1 = Effect_teleport.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(fx1)

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
	# enables input and physics again

# This keeps track of the keys used to switch between players
func _input(event):
	if Input.is_key_pressed(KEY_1) and Cam_2.is_current():
		teleport()
		yield(get_tree().create_timer(0.5), "timeout")
		Cam_2.set_current(0)
		Cam_1.set_current(1)
		my_pause(Play_2)
		my_resume(Play_1)
	if Input.is_key_pressed(KEY_2) and Cam_1.is_current():
		teleport()
		yield(get_tree().create_timer(0.5), "timeout")
		Cam_1.set_current(0)
		Cam_2.set_current(1)
		my_pause(Play_1)
		my_resume(Play_2)

# This part onward controls how doors work in this level.
func _on_door_level_body_entered(body):
	if body.is_in_group("Player"):
		level1 = true
	else:
		level1 = false

func _on_Player_beep():
	if level2:
		door1.set_visible(true)
		door1_sound.play()
	if level1:
		door2.set_visible(true)
		door2_sound.play()
	if level3:
		door3.set_visible(true)
		door3_sound.play()
	if level4:
		door4.set_visible(true)
		door4_sound.play()

func _on_door_level2_body_entered(body):
	if body.is_in_group("Player"):
		level2 = true
	else:
		level2 = false


func _on_event1_trigger_body_entered(body):
	if body.is_in_group("Player") and script_1_done == false:
		script_1.apply_impulse(Vector3(0,0,0), Vector3(10,0,0))
		script_1_done = true


func _on_door_level3_body_entered(body):
	if body.is_in_group("Player"):
		level3 = true
	else:
		level3 = false


func _on_door_level4_body_entered(body):
	if body.is_in_group("Player"):
		level4 = true
	else:
		level4 = false


func _on_next_level_body_entered(body):
	if body.is_in_group("Player"):
		get_node(global).setScene("res://assets/scenes/level1.tscn")
