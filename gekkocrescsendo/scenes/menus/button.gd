extends Button

func _on_pressed() -> void:
	await SceneHelper.change_scenes(get_tree(), "res://scenes/levels/slab-level/slab-level.tscn");
