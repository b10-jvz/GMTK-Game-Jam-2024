extends CharacterBody3D
class_name FriendlyGecko

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var targetNode : Node3D

func _physics_process(delta: float) -> void:	
	if targetNode == null: return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := (targetNode.global_position - global_position).normalized();
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
