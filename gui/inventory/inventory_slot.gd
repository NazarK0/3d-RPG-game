class_name InventorySlot extends PanelContainer

signal pressed

@export var _type: InventoryData.TYPE

func init(type: InventoryData.TYPE, cms: Vector2)-> void:
	_type = type
	custom_minimum_size = cms
	
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

	data.reparent(self)


func _gui_input(event: InputEvent) -> void:
	pass
