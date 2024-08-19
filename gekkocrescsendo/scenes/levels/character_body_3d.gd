extends CharacterBody3D
class_name FancyPlayer
const SPEED = 8
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 3.0

var MyParty : Array = []
var FollowNodes : Array
var RockFollowNode : Node3D
var RNG : RandomNumberGenerator

var lookingAt : Boulder

func _init() -> void:	
	RNG = RandomNumberGenerator.new()
	
func _ready():
	FollowNodes = $FollowNodes.get_children()
	(get_tree().root.get_node("/root/GameState")).Player = self
	var anim =(get_node("gecko/AnimationPlayer") as AnimationPlayer)
	anim.get_animation("Armature_006").length = .80
	anim.speed_scale = 3

func _physics_process(delta: float) -> void:
	if !get_parent().game_started: return
	# Add the gravity.	
	if not is_on_floor():
		velocity += get_gravity() * delta

	$gecko/AnimationPlayer.play("Armature_006")
	
	if Input.is_action_pressed("ui_left"):
		rotate_y(ROTATION_SPEED * delta)
	if Input.is_action_pressed("ui_right"):
		rotate_y(-ROTATION_SPEED * delta)
	
	var input_dir := Input.get_axis("ui_up", "ui_down")
	var direction := (transform.basis * Vector3(0, 0,input_dir)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if !Input.is_anything_pressed():
		$gecko/AnimationPlayer.pause()
	

	move_and_slide()
	

func get_unoccupied_spaces():
	if MyParty.is_empty() : return FollowNodes
	return FollowNodes.slice(MyParty.size()-1,FollowNodes.size())
	
	
func occupy_space(friend:FriendlyGecko):
	MyParty.push_back(friend)
	var targetNode = get_unoccupied_spaces().front()
	friend.targetNode = targetNode
	print(targetNode)

func _process(delta: float) -> void:
	if !get_parent().game_started: return
	
	if($RayCast3D.is_colliding()):
		var boulder = $RayCast3D.get_collider().get_parent()
		if (boulder is Boulder):	
			boulder.Player = self		
			$InterractText.text = "Press (E) to interract with " + boulder.name
			lookingAt = boulder
			$InterractText.show()
	else:
		lookingAt = null
		$InterractText.hide()
		
		
func _input(event: InputEvent) -> void:
	if !get_parent().game_started: return
	if(event.is_action_pressed("ui_select") and lookingAt != null):
		var boulderThreshold = lookingAt.TargetNodes.size()		
		for i in range (0,boulderThreshold):
			var partyMemberToDeploy = MyParty.pop_back()
			if partyMemberToDeploy == null:
				return
			else:
				lookingAt.occupy_space(partyMemberToDeploy)
		
		#for i in range (0,boulderThreshold-1):
			#lookingAt.MyParty.pop_back()
		
		
		

func _on_touch_area_body_entered(body: Node3D) -> void:	
	if body is FriendlyGecko and !MyParty.has(body):
		occupy_space(body)		
		print(body.name + " touched me, hees following ME")
		body.get_node("CollisionShape3D").disabled = true
	print(MyParty)
	pass # Replace with function body.
