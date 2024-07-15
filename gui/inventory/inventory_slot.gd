class_name InventorySlot extends PanelContainer

@export var _type: InventoryData.TYPE

func init(type: InventoryData.TYPE, cms: Vector2)-> void:
	_type = type
	custom_minimum_size = cms
	
func _physics_process(delta: float) -> void:
	if get_child_count() > 0:
		var item: InventoryItem  = get_child(0)
					
		#Game.head_equipment = item._data if (_type == InventoryData.TYPE.HEAD) else null
		#Game.neck_equipment = item._data if (_type == InventoryData.TYPE.NECK) else null
		#Game.hands_equipment = item._data if (_type == InventoryData.TYPE.HAND) else null
		#Game.left_hand_weapon = item._data if (_type == InventoryData.TYPE.WEAPON_LH) else null
		#Game.left_hand_weapon = item._data if (_type == InventoryData.TYPE.WEAPON_LH) else null
		#Game.body_equipment = item._data if (_type == InventoryData.TYPE.BODY) else null
		#Game.legs_equipment = item._data if (_type == InventoryData.TYPE.LEG) else null
		#Game.anklet_equipment = item._data if (_type == InventoryData.TYPE.ANKLE) else null
		#Game.feet_equipment = item._data if (_type == InventoryData.TYPE.FEET) else null
		
		#print(Game.fingers_equipment, "fingers")
		
		
		#if _type == InventoryData.TYPE.FINGER:
			#var number: int = int(name.trim_prefix("Ring"))
			#
			#if name.begins_with("Ring"):
				#Game.fingers_equipment[number] = item._data
			
		#else:
			#
			#
		#print(Game.fingers_equipment, " RING NUMBER")
	
func  _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if _type == InventoryData.TYPE.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if _type == data.get_parent()._type:
					return true
					
				return get_child(0)._data.type == data._data.type
		else:
			return data._data.type == _type
	else:
		return false
	

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item := get_child(0)
		
		if item == data:
			return
			
		item.reparent(data.get_parent())
		print("drop parent")
			
		
		
	
	print("drop self")
	data.reparent(self)


func _gui_input(event: InputEvent) -> void:
	pass
