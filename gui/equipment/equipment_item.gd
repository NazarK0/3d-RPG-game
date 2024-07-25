class_name EquipmentItem extends TextureButton

@export var _data: EquipmentData
#@export var _item_info_panel_path: NodePath

func init(data: EquipmentData) -> void:
	_data = data
	
	
func makeDragPreview(at_position: Vector2) -> Control:
	var control := Control.new()
	var tb := TextureButton.new()
	
	tb.texture_normal = self.texture_normal
	tb.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	tb.custom_minimum_size = self.size
	tb.modulate.a = 0.5
	tb.position = Vector2(-at_position)
	
	control.add_child(tb)
	
	return control

func _ready() -> void:
	if _data:
		stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		texture_normal = _data.texture
		tooltip_text = "%s" \
			% [_data.item_name, 
			]
		
		
	

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(makeDragPreview(at_position))
	return self

	
func _pressed() -> void:
	print('Pressed Eq')
	

