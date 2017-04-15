extends SamplePlayer

onready var player = SamplePlayer

func _ready():
	pass
	
func on_moving():
	var voiceid_footsteps = play("footsteps", true)
	set_volume(voiceid_footsteps, 0.5)