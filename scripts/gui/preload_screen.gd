extends CanvasLayer

@export var new_game_scene: PackedScene
var simultaneous_scene = preload("res://scenes/levels/level_1.tscn").instantiate()



func _on_new_game_pressed() -> void:
	# 1st
	print("change")
	get_tree().root.add_child.call_deferred(simultaneous_scene)
	self.hide()
	
	# 2nd 
	#get_tree().change_scene_to_packed(new_game_scene)
	
	# 3rd
	#get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
