extends RigidBody

func _ready():
	pass

func _physics_process(delta):
	var ouch = $"."
	var loor = ouch.get_angular_velocity()
	print(loor)
