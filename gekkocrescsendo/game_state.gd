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
	if Player == null: 
		return
	for i in (Player.MyParty.size() - 1):
		var audioStreamPlayer = (streams[i+1] as AudioStreamPlayer)
		if audioStreamPlayer == null: 
			continue
		audioStreamPlayer.volume_db = 0.0 - (i * 0.25)
	for i in 5 - Player.MyParty.size():
		if i == 5:
			continue
		var audioStreamPlayer = (streams[5-i] as AudioStreamPlayer)
		if audioStreamPlayer == null: 
			continue
		audioStreamPlayer.volume_db = -80.0
