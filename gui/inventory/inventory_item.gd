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
	
	var item_info_panel = get_node(_item_info_panel_path)
	
	if (not item_info_panel.visible):
		item_info_panel.visible = true
		
	item_info_panel.find_child("Item").texture = texture_normal
	item_info_panel.find_child("Description").text = _data.description
	
	item_info_panel.find_child("WeaponStats").visible = false
	item_info_panel.find_child("ShieldStats").visible = false
	item_info_panel.find_child("ArmourStats").visible = false
	item_info_panel.find_child("RingStats").visible = false
	item_info_panel.find_child("CureStats").visible = false
	item_info_panel.find_child("KeyStats").visible = false
	item_info_panel.find_child("SpellStats").visible = false
	item_info_panel.find_child("PiromancyStats").visible = false
	item_info_panel.find_child("IngredientStats").visible = false
	item_info_panel.find_child("BookStats").visible = false
	item_info_panel.find_child("NoteStats").visible = false
	item_info_panel.find_child("MiscStats").visible = false

	match _data.type:
		InventoryData.TYPE.WEAPON:
			var weapon = item_info_panel.find_child("WeaponStats")
			
			weapon.visible = true			
			weapon.find_child("Weight").find_child("value").text = str(_data.weight)
			weapon.find_child("Damage").find_child("value").text = str(_data.item_damage)
			weapon.find_child("Health").find_child("value").value = _data.item_health
			
			displayRequiredSkills(weapon, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.SHIELD:
			var shield = item_info_panel.find_child("ShieldStats")
			
			shield.visible = true
			shield.find_child("Weight").find_child("value").text = str(_data.weight)
			shield.find_child("Damage").find_child("value").text = str(_data.item_damage)
			shield.find_child("Defence").find_child("value").text = str(_data.item_defence)
			shield.find_child("Health").find_child("value").value = _data.item_health
			
			displayRequiredSkills(shield, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.ARMOUR:
			var armour = item_info_panel.find_child("ArmourStats")
			
			armour.visible = true
			armour.find_child("Weight").find_child("value").text = str(_data.weight)
			armour.find_child("Damage").find_child("value").text = str(_data.item_damage)
			armour.find_child("Defence").find_child("value").text = str(_data.item_defence)
			armour.find_child("Health").find_child("value").value = _data.item_health
			
			displayRequiredSkills(armour, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.RING:
			var ring = item_info_panel.find_child("RingStats")
			
			ring.visible = true
			ring.find_child("Weight").find_child("value").text = str(_data.weight)
						
			displayRequiredSkills(ring, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.CURE:
			var cure = item_info_panel.find_child("CureStats")
			
			cure.visible = true
			cure.find_child("Weight").find_child("value").text = str(_data.weight)
						
			displayRequiredSkills(cure, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.KEY:
			var key = item_info_panel.find_child("KeyStats")
			
			key.visible = true
			key.find_child("Weight").find_child("value").text = str(_data.weight)
		InventoryData.TYPE.SPELL:
			var spell = item_info_panel.find_child("SpellStats")
			
			spell.visible = true
			displayRequiredSkills(spell, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.PIROMANCY:
			var piromancy = item_info_panel.find_child("PiromancyStats")
			
			piromancy.visible = true
			displayRequiredSkills(piromancy, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.INGREDIENTS:
			var ingredient = item_info_panel.find_child("IngredientStats")
			
			ingredient.visible = true
			ingredient.find_child("Weight").find_child("value").text = str(_data.weight)
		InventoryData.TYPE.BOOKS:
			var book = item_info_panel.find_child("BookStats")
			
			book.visible = true
			book.find_child("Weight").find_child("value").text = str(_data.weight)
						
			displayRequiredSkills(book, _data.required_skills, _data.required_skill_values)
		InventoryData.TYPE.NOTES:
			item_info_panel.find_child("NoteStats").visible = true
			var note = item_info_panel.find_child("NoteStats")
			
			note.visible = true
			note.find_child("CreatedAt").find_child("value").text = str(_data.created_at)
		InventoryData.TYPE.MISC:
			var misc = item_info_panel.find_child("MiscStats")
			
			misc.visible = true
			misc.find_child("Weight").find_child("value").text = str(_data.weight)
						
			displayRequiredSkills(misc, _data.required_skills, _data.required_skill_values)
		

func displayRequiredSkills(base: Node, skills: Array[InventoryData.SKILLS], values: Array[int]) -> void:
	var strength = base.find_child("Strength")
	var agility = base.find_child("Agility")
	var holiness = base.find_child("Holiness")
	
	if not strength and not agility and not holiness: return
	
	if strength:
		strength.visible = false
		
	if agility:
		agility.visible = false
	
	if holiness:
		holiness.visible = false
	
	for rs_idx in range(skills.size()):
		match skills[rs_idx]:
			InventoryData.SKILLS.STRENGTH:
				strength.find_child("value").text = str(values[rs_idx])
				strength.visible = true
			InventoryData.SKILLS.AGILITY:
				agility.find_child("value").text = str(values[rs_idx])
				agility.visible = true
			InventoryData.SKILLS.HOLINESS:
				holiness.find_child("value").text = str(values[rs_idx])
				holiness.visible = true
