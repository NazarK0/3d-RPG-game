extends CanvasLayer

@export var main_menu: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	($ShowTimer as Timer).start()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

func _on_show_timer_timeout() -> void:
	get_tree().change_scene_to_packed(main_menu)
