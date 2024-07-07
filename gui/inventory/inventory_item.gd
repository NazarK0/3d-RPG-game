class_name InventoryItem extends TextureRect

@export var _data: InventoryData

func init(data: InventoryData) -> void:
	_data = data
	
func makeDragPreview(at_position: Vector2) -> Control:
	var control := Control.new()
	var tr := TextureRect.new()
	
	tr.texture = self.texture
	tr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	tr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	tr.custom_minimum_size = self.size
	tr.modulate.a = 0.5
	tr.position = Vector2(-at_position)
	
	control.add_child(tr)
	
	return control

func _ready() -> void:
	if _data:
		expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture = _data.texture
		tooltip_text = "%s\n%s\nStats: %s Damage, %s Defence, %s Health" \
			% [_data.item_name, 
				_data.description, 
				_data.item_damage, 
				_data.item_defence,
				_data.item_health,
			]
		
		if _data.stackable:
			var label := Label.new()
			
			label.text = str(_data.count)
			label.position = Vector2(24, 16)
			add_child(label)
	

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(makeDragPreview(at_position))
	return self
	


