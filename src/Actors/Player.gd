extends Actor

export var stomp_impulse = 1000.0

func _on_EnemyDetector_area_entered(area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body):
	queue_free()

func _physics_process(delta):
	var direction: = get_direction()
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	
	_velocity = calc_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, Vector2.UP)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calc_move_velocity(
		linear_velocity: Vector2, 
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	
	if is_jump_interrupted: 
		out.y = 0.0
	
	return out
	
func calculate_stomp_velocity(linear_velocity: Vector2, impulse):
	var out: = linear_velocity
	out.y = -impulse
	
	return out




