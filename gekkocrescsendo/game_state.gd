extends Node


var Player : FancyPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var streams = $MusicLayers.get_children()
	if Player == null: return
	for i in Player.MyParty.size():
		(streams[i] as AudioStreamPlayer).volume_db = 0.0
