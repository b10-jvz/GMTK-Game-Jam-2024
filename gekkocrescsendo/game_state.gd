extends Node

var Player : FancyPlayer

var MaximumReached : bool = false
var LastPartySize : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if MaximumReached:
		return
	
	var streams = $MusicLayers.get_children()
	if Player == null: 
		return
		
	var partySize = Player.MyParty.size()
	if partySize == LastPartySize:
		return
	
	var audioStreamPlayer0 = streams[0] as AudioStreamPlayer
	
	if (partySize == 1):
		LastPartySize = 1
		var audioStreamPlayer1 = streams[1] as AudioStreamPlayer
		var audioStreamPlayer3 = streams[3] as AudioStreamPlayer
		
		audioStreamPlayer1.seek(audioStreamPlayer0.get_playback_position())
		audioStreamPlayer3.seek(audioStreamPlayer0.get_playback_position())
		audioStreamPlayer1.volume_db = 0
		audioStreamPlayer3.volume_db = -4
		
	if (partySize == 2):
		LastPartySize = 2
		var audioStreamPlayer2 = streams[2] as AudioStreamPlayer
		
		audioStreamPlayer2.seek(audioStreamPlayer0.get_playback_position())
		audioStreamPlayer2.volume_db = -0.4

	if (partySize == 3):
		LastPartySize = 3
		var audioStreamPlayer4 = streams[4] as AudioStreamPlayer
		var audioStreamPlayer5 = streams[5] as AudioStreamPlayer
		
		audioStreamPlayer4.seek(audioStreamPlayer0.get_playback_position())
		audioStreamPlayer5.seek(audioStreamPlayer0.get_playback_position())
		audioStreamPlayer4.volume_db = 0.15
		audioStreamPlayer5.volume_db = -15
		MaximumReached = true
