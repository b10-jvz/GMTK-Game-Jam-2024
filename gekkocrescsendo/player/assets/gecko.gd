@tool
extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.autoplay = "Armature|ArmatureAction_001"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
