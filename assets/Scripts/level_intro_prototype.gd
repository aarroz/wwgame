extends Spatial

var door1
var door2
var level1
var level2
var door1_sound
var door2_sound

var script_1
var script_1_done

func _ready():
	door1 = $spawn_room/door
	door2 = $spawn_room/door2
	door1_sound = $door_level/notify
	door2_sound = $door_level2/notify2
	level1 = false
	level2 = false
	script_1_done = false
	script_1 = $physics_objects/scripted_crate

func _on_door_level_body_entered(body):
	if body.name == "Player":
		level1 = true
	else:
		level1 = false

func _on_Player_beep():
	if level1:
		door1.set_visible(true)
		door1_sound.play()
	if level2:
		door2.set_visible(true)
		door2_sound.play()


func _on_door_level2_body_entered(body):
	if body.name == "Player":
		level2 = true
	else:
		level2 = false


func _on_event1_trigger_body_entered(body):
	if body.name == "Player" and script_1_done == false:
		script_1.apply_impulse(Vector3(0,0,0), Vector3(10,0,0))
		script_1_done = true
