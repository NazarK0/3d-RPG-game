class_name InventorySlot extends PanelContainer

@export var _type: ItemData.Type

func init(type: ItemData.Type, cms: Vector2)-> void:
	_type = type
	custom_minimum_size = cms
	
func _physics_process(delta: float) -> void:
	pass
	
func  _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if _type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if _type == data.get_parent()._type:
					return true
					
				return get_child(0).data.type == data.data.type
		else:
			return data.data.type == _type
	else:
		return false
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item := get_child(0)
		
		if item == data:
			return
			
		item.reparent(data.get_parent())
		
		
	data.reparent(self)
	


func _gui_input(event: InputEvent) -> void:
	pass
