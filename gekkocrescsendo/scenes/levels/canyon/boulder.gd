@tool
extends Node3D

class_name Boulder

var MyParty : Array = []
var TargetNodes : Array = []
const SPEED = 5.0
var FollowNode : Node3D

var Player : FancyPlayer

var _type = 0
@export_enum("Sharp","Smooth","Chunky") var BoulderType : set = _set_type, get = _get_type

func _set_type(type):
	if($Meshes == null):return
	_type = type
	var boulders = $Meshes.get_children()
	for boulder in boulders:
		boulder.hide()
	boulders[type].show()

func _get_type():
	return _type

var _roll_speed = 0.0
@export_range(0.0,2.0) var RollSpeed : float : set = _set_speed, get = _get_speed

func _set_speed(speed):
	_roll_speed = speed
	$AnimationPlayer.stop()
	pass
	
func _get_speed():
	return _roll_speed	

# Called when the node enters the scene tree for the first time.
func _ready():
	TargetNodes = $TargetNodes.get_children()
	Player = get_tree().root.get_node("/root/GameState").Player
	pass # Replace with function body.

func get_unoccupied_spaces():
	if MyParty.is_empty() : return TargetNodes
	return TargetNodes.slice(MyParty.size()-1,TargetNodes.size())
	
	
func occupy_space(friend:FriendlyGecko):
	MyParty.push_back(friend)
	friend.targetNode = get_unoccupied_spaces().front()	
	$Timer.start()
	if(MyParty.size() == 3):
		FollowNode = Player.get_node("RockFollowNode")
		RollSpeed = .1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if RollSpeed > 0.0 and !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("roll",-1,RollSpeed)
	if RollSpeed == 0.0:
		$AnimationPlayer.stop()		
	pass
	
func _physics_process(delta: float) -> void:	
	if FollowNode == null: return
	# Add the gravity.
	var direction := FollowNode.global_position - global_position	
	direction = direction.normalized()	
	global_position += direction * delta * SPEED

func _on_timer_timeout() -> void:
	if (MyParty.size() == 3): return
	for gecko in MyParty:		
		Player.occupy_space(gecko)
	
	MyParty.clear()
	pass # Replace with function body.
