extends ColorRect
onready var animation = $AnimationPlayer

func _ready():
	animation.play("Blink")
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()


