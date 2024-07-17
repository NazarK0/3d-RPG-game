class_name InventoryItem extends TextureButton

@export var _data: InventoryData
@export var _item_info_panel_path: NodePath

func init(data: InventoryData, item_info_panel_path: NodePath) -> void:
	_data = data
	_item_info_panel_path = item_info_panel_path
	
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
	print(_item_info_panel_path, 'RINFO')
	if _data:
		stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		texture_normal = _data.texture
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

	
func _pressed() -> void:
	var info = "%s\n%s\nStats: %s Damage, %s Defence, %s Health" \
					% [_data.item_name, 
						_data.description, 
						_data.item_damage, 
						_data.item_defence,
						_data.item_health,
					]
	print(info)
	
	var item_info_panel = get_node(_item_info_panel_path)
	
	if (not item_info_panel.visible):
		item_info_panel.visible = true
		
	item_info_panel.find_child("Item").texture = texture_normal
	item_info_panel.find_child("Description").text = _data.description
	
	item_info_panel.find_child("WeaponStats").visible = false
	item_info_panel.find_child("ShieldStats").visible = true
	item_info_panel.find_child("ArmourStats").visible = true
	item_info_panel.find_child("RingStats").visible = true
	item_info_panel.find_child("CureStats").visible = true
	item_info_panel.find_child("KeyStats").visible = true
	item_info_panel.find_child("SpellStats").visible = true
	item_info_panel.find_child("PiromancyStats").visible = true
	item_info_panel.find_child("IngredientStats").visible = true
	item_info_panel.find_child("BookStats").visible = true
	item_info_panel.find_child("NoteStats").visible = true
	item_info_panel.find_child("MiscStats").visible = true

	match _data.type:
		InventoryData.TYPE.WEAPON:
			var weapon = item_info_panel.find_child("WeaponStats")
			weapon.visible = true
			weapon.find_child("Damage").find_child("value").text = str(_data.item_damage)
		InventoryData.TYPE.SHIELD:
			item_info_panel.find_child("ShieldStats").visible = true
		InventoryData.TYPE.ARMOUR:
			item_info_panel.find_child("ArmourStats").visible = true
		InventoryData.TYPE.RING:
			item_info_panel.find_child("RingStats").visible = true
		InventoryData.TYPE.CURE:
			item_info_panel.find_child("CureStats").visible = true
		InventoryData.TYPE.KEY:
			item_info_panel.find_child("KeyStats").visible = true
		InventoryData.TYPE.SPELL:
			item_info_panel.find_child("SpellStats").visible = true
		InventoryData.TYPE.PIROMANCY:
			item_info_panel.find_child("PiromancyStats").visible = true
		InventoryData.TYPE.INGREDIENTS:
			item_info_panel.find_child("IngredientStats").visible = true
		InventoryData.TYPE.BOOKS:
			item_info_panel.find_child("BookStats").visible = true
		InventoryData.TYPE.NOTES:
			item_info_panel.find_child("NoteStats").visible = true
		InventoryData.TYPE.MISC:
			item_info_panel.find_child("MiscStats").visible = true
		
		
			
	#item_info_panel.find_child("Description").text = _data.description
