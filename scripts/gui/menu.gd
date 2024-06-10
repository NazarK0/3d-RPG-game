extends CanvasLayer

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_game_pressed() -> void:
	LoadManager.loadScene("res://scenes/levels/new_game.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gui/settings.tscn")
