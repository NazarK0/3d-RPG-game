class_name EquipmentSlot extends TextureButton
	
@export var _type: EquipmentData.TYPE

func _physics_process(delta: float) -> void:
	if get_child_count() > 0:
		var item: EquipmentItem  = get_child(0)
					
		save_to_ram(item)

#func _gui_input(event: InputEvent) -> void:
	#pass

func save_to_ram(item: EquipmentItem) -> void:
	pass
	#Game.head_equipment = item._data if (_type == InventoryData.TYPE.HEAD) else null
	#Game.neck_equipment = item._data if (_type == InventoryData.TYPE.NECK) else null
	#Game.hands_equipment = item._data if (_type == InventoryData.TYPE.HAND) else null
	#Game.left_hand_weapon = item._data if (_type == InventoryData.TYPE.WEAPON_LH) else null
	#Game.left_hand_weapon = item._data if (_type == InventoryData.TYPE.WEAPON_LH) else null
	#Game.body_equipment = item._data if (_type == InventoryData.TYPE.BODY) else null
	#Game.legs_equipment = item._data if (_type == InventoryData.TYPE.LEG) else null
	#Game.anklet_equipment = item._data if (_type == InventoryData.TYPE.ANKLE) else null
	#Game.feet_equipment = item._data if (_type == InventoryData.TYPE.FEET) else null
func _pressed() -> void:
	print('Pressed Eq')
