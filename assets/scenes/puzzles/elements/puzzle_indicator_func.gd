extends Spatial

onready var model = $CSGCylinder

func _ready():
	model.material.set_albedo(Color(255, 0, 0, 0))

func indicator_on():
	model.material.set_albedo(Color(0, 255, 0))

func indicator_off():
	model.material.set_albedo(Color(255, 0, 0))
