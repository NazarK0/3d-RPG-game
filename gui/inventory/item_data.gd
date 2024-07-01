class_name ItemData extends Resource

enum Type {WEAPON, ARMOUR, HELMET, GLOVES, RINGS, CURE, BOOTS, MISC, MAIN}

@export var texture: Texture2D
@export var type: Type
@export var item_name: String
@export var item_damage: int
@export var item_health: int
@export var item_defence: int
@export var stackable: bool
@export var count: int
@export_multiline var description: String

