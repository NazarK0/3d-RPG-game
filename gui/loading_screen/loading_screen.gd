class_name LoadingScreen extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = $Control/Panel/ProgressBar

func _updateProgressBar(new_value: float) -> void:
	#print(new_value, "new value")
	progress_bar.set_value_no_signal(new_value * 100.0)
	
	
func _startOutroAnimation() -> void:
	#print('outro')
	#Signal(animation_player, "animation_finished")
	animation_player.play("end_load")
	await Signal(animation_player, "animation_finished")
	self.queue_free()
