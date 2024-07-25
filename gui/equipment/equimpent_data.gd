class_name EquipmentData extends Resource
	
enum TYPE {
	HEAD, 
	BODY, 
	FINGER, 
	HAND,
	NECK, 
	LEG,
	ANKLE, 
	FEET, 
	WEAPON_LH,
	WEAPON_RH,
	ARROW,
	WRIST,
	QUICK_ACCESS,
}

@export var data: InventoryData
@export var equipment_type: Array[TYPE]


