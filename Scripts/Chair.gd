extends RigidBody

func _ready():
	set_max_contacts_reported(10)
	set_contact_monitor(true)
func is_allowed_to_move():
	var colliders = get_colliding_bodies()
  
	for collider in colliders:
    
    	if (not collider.is_in_group("moveable")):
    		return false
  
	return true