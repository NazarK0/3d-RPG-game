class_name EquipmentSlot extends PanelContainer
	
@export var _type: EquipmentData.TYPE

func _physics_process(delta: float) -> void:
	if get_child_count() > 0:
		var item: InventoryItem  = get_child(0)
					
		Game.head_equipment = item._data if (_type == EquipmentData.TYPE.HEAD) else null
		Game.neck_equipment = item._data if (_type == EquipmentData.TYPE.NECK) else null
		Game.hands_equipment = item._data if (_type == EquipmentData.TYPE.HAND) else null
		Game.left_hand_weapon = item._data if (_type == EquipmentData.TYPE.WEAPON_LH) else null
		Game.left_hand_weapon = item._data if (_type == EquipmentData.TYPE.WEAPON_LH) else null
		Game.body_equipment = item._data if (_type == EquipmentData.TYPE.BODY) else null
		Game.legs_equipment = item._data if (_type == EquipmentData.TYPE.LEG) else null
		Game.anklet_equipment = item._data if (_type == EquipmentData.TYPE.ANKLE) else null
		Game.feet_equipment = item._data if (_type == EquipmentData.TYPE.FEET) else null
		
		#print(Game.fingers_equipment, "fingers")
		
		
		if _type == EquipmentData.TYPE.FINGER:
			var number: int = int(name.trim_prefix("Ring"))
			
			if name.begins_with("Ring"):
				Game.fingers_equipment[number] = item._data
			
		#else:
			#
			#
		#print(Game.fingers_equipment, " RING NUMBER")
	


#func _drop_data(_at_position: Vector2, data: Variant) -> void:
	#if get_child_count() > 0:
		#var item := get_child(0)
		#
		#if item == data:
			#return
			#
		#item.reparent(data.get_parent())
		#print("drop parent")
			#
		#
		#
	#
	#print("drop self")
	#data.reparent(self)


func _gui_input(event: InputEvent) -> void:
	pass
