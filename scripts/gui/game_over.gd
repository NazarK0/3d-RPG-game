extends CanvasLayer

@export var main_menu: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShowTimer.start()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
#func gameOver() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#self.show()
	


func _on_show_timer_timeout() -> void:
	get_tree().change_scene_to_packed(main_menu)
