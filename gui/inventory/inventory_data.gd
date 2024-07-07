class_name InventoryData extends Resource

enum TYPE {
	WEAPON, 
	SHIELD, 
	ARMOUR, 
	RING, 
	CURE,
	KEY, 
	SPELL, 
	PIROMANCY, 
	INGREDIENTS,
	BOOKS, 
	NOTES,
	MISC,
	MAIN
	}
	
@export var texture: Texture2D
@export var type: TYPE
@export var equipment_type: Array[EquipmentData.TYPE]
@export var item_name: String
@export var item_damage: int
@export var item_health: int
@export var item_defence: int
@export var stackable: bool
@export var count: int
@export_multiline var description: String

