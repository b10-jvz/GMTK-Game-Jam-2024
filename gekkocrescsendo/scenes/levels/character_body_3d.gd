extends CharacterBody3D
class_name Player
const SPEED = 500.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 3.0

var MyParty : Array = []
var RNG : RandomNumberGenerator

func _init() -> void:
	
	RNG = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	$gecko/AnimationPlayer.play("Armature_003")
	
	if Input.is_action_pressed("ui_left"):
		rotate_y(ROTATION_SPEED * delta)
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	if Input.is_action_pressed("ui_right"):
		rotate_y(-ROTATION_SPEED * delta)
	
	if Input.is_action_pressed("ui_up"):
		velocity = global_transform.basis.z.normalized() * SPEED * delta * -1 
		
	if Input.is_action_pressed("ui_down"):
		velocity = global_transform.basis.z.normalized() * SPEED * delta
		
	if !Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down"):
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if !Input.is_anything_pressed():
		$gecko/AnimationPlayer.pause()
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_touch_area_body_entered(body: Node3D) -> void:	
	if body is FriendlyGecko and !MyParty.has(body):
		var followNodeIndex = RNG.randi_range(0,4)
		var TargetNodes = [$FollowNode1, $FollowNode2, $FollowNode3, $FollowNode4, $FollowNode5]
		var takenTargetNodes = MyParty.map(func(x): return x.targetNode)		
		
		body.targetNode = TargetNodes[MyParty.size() - 1]
		MyParty.append(body)
		print(body.name + " touched me, hees following ME")
	pass # Replace with function body.
