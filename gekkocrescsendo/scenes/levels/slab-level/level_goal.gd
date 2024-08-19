extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(-.5))
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Boulder:
		body.FollowNode = null
		$Timer.start()
	
func _on_timer_timeout() -> void:
	get_parent().game_started = false
	$AnimationPlayer.play("end")

func _on_animation_player_animation_finished_end_game(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/menus/Credits.tscn")
