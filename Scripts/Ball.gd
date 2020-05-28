extends RigidBody2D

const SPEED_UP = 400
const MAX_SPEED = 30000

func _ready():
	set_physics_process(true)
	print('ready')

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.queue_free()
		
		if body.get_name() == "Paddle":
			var speed = get_linear_velocity().length()
			var direction = position - body.get_node("Anchor").global_transform.origin
			var velocity = direction.normalized() * min(speed + SPEED_UP, MAX_SPEED)
			set_linear_velocity(velocity)
	
	if position.y > get_viewport_rect().end.y:
		queue_free()
