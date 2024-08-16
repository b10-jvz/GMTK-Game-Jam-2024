extends Button

func _on_pressed() -> void:
	await SceneHelper.change_scenes(get_tree(), "res://scenes/levels/canyon.tscn");
