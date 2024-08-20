@tool
extends Node3D

var _type = 0
@export_enum("Type1","Type2","Type3","Type4") var BoulderType : set = _set_type, get = _get_type

func _set_type(type):
	if($Sprites == null): return
	_type = type
	var boulders = $Sprites.get_children()
	for boulder in boulders:
		boulder.hide()
	boulders[type].show()

func _get_type():
	return _type
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
