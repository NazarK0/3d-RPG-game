extends Node

const FINGERS_COUNT: int = 10
const INVENTORY_SLOT_SIZE: int = 32
const INVENTORY_MIN_SLOTS_COUNT = 208
const INVENTORY_TABS: Array[StringName] = [
	"Weapon", 
	"Shield", 
	"Armour", 
	"Rings", 
	"Cure",
	"Keys",
	"Spell",
	"Piromancy",
	"Ingredients",
	"Books",
	"Notes",
	"Misc",	
	]

var player_health :int = 10

var head_equipment: InventoryData
var neck_equipment: InventoryData
var hands_equipment: InventoryData
var fingers_equipment: Array[InventoryData]
var right_hand_weapon: InventoryData
var left_hand_weapon: InventoryData
var body_equipment: InventoryData
var legs_equipment: InventoryData
var anklet_equipment: InventoryData
var feet_equipment: InventoryData

func _ready() -> void:
	fingers_equipment.resize(FINGERS_COUNT)
