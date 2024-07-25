extends AcceptDialog


func _ready() -> void:
	add_cancel_button("Cancel")
	ok_button_text = "Confirm"

func _on_weapon_r_3_pressed() -> void:
	popup_centered_ratio(0.95)
	get_ok_button().disabled = true
