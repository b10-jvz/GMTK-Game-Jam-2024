extends Node3D

var game_started =false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Cutscene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimationPlayer/Path3D/PathFollow3D/Camera3D.look_at($Boulder.global_position)
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer/Path3D/PathFollow3D/Camera3D.current= false
	$Player3DBody/Camera3D.current = true
	$RichTextLabel.hide()
	$AcceptDialog.show()



func _on_accept_dialog_confirmed() -> void:
	game_started = true
