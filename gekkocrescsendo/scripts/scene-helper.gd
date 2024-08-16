class_name SceneHelper

# Countdown which returns the player in x seconds to the scene at path
static func change_scenes(current_scene: SceneTree, path_to_scene: String, delay_in_seconds: float = 0) -> void:
	for second in delay_in_seconds:
		print("Changing scenes in %d seconds.." % (delay_in_seconds - second));
		await current_scene.create_timer(1).timeout;
	await current_scene.change_scene_to_file(path_to_scene);
