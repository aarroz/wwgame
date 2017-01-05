extends RigidBody

var selected = false
var speed = 1
var X = 0.00
var Y = 0.00
var Z = 0.00

func _input(event):
	if (not Input.is_action_pressed("ClickAction") and selected):
		selected = false
		set_mode(MODE_RIGID)
		set_process_input(false)

	if (event.type == InputEvent.MOUSE_MOTION and selected):
		get_global_transform().origin
		X += event.relative_x*.02
		Y += event.relative_y*.02
		set_translation(Vector3(X, -Y, 0))
		
func _input_event(camera, event, click_pos, click_normal, shape_idx):
	if (Input.is_action_pressed("ClickAction") and not selected):
		selected = true
		set_mode(MODE_STATIC)
		set_process_input(true)
	
#func _mouse_exit():
#	selected = false
#	set_mode(MODE_RIGID)