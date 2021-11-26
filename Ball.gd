extends RigidBody2D

func _process(delta):
	var accelerator = Input.get_accelerometer()
	applied_force = Vector2(accelerator.x, -accelerator.y) * 5000 * delta	
