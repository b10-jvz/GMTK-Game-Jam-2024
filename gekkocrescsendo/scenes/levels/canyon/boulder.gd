@tool
extends Node3D

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if RollSpeed > 0.0 and !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("roll",-1,RollSpeed)
	if RollSpeed == 0.0:
		$AnimationPlayer.stop()		
	pass
