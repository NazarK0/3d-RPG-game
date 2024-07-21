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
	
enum SKILLS {
	STRENGTH,
	AGILITY,
	HOLINESS
}


	
@export var texture: Texture2D
@export var type: TYPE
@export var equipment_type: Array[EquipmentData.TYPE]
@export var item_name: String
@export var item_damage: int
@export var item_defence: int
@export var item_health: int
@export var weight: float
@export var required_skills: Array[SKILLS]
@export var required_skill_values: Array[int]
@export var stackable: bool
@export var count: int
@export_multiline var description: String

