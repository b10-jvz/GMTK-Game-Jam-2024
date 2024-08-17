extends CharacterBody3D


const SPEED = 50.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 3.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	
	if Input.is_action_pressed("ui_left"):
		rotate_y(ROTATION_SPEED * delta)
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	if Input.is_action_pressed("ui_right"):
		rotate_y(-ROTATION_SPEED * delta)
	
	if Input.is_action_pressed("ui_up"):
		velocity = global_transform.basis.z.normalized()
		
	if Input.is_action_pressed("ui_down"):
		velocity = global_transform.basis.z.normalized() * -1
		
	if !Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down"):
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
