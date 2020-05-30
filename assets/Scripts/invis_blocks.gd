extends Spatial

var event1

func _ready():
	event1 = $first_event/first_body

func _on_Area_body_entered(body):
	if body.name == "Player":
		print("Hello Player")
		event1.set_disabled(true)
