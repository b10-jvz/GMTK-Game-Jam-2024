extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await SceneHelper.change_scenes(get_tree(), "res://scenes/menus/home.tscn", 5);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
