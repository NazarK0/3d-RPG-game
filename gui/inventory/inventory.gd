extends Control

const SLOT_SIZE: int = 32
const INVENTORY_MIN_SIZE = 144

@onready var grid := $GridContainer
var items_to_load = [
	"res://gui/inventory/item_resources/armour/set/knight/knight_armour.tres",
	"res://gui/inventory/item_resources/armour/set/knight/knight_boots.tres",
	"res://gui/inventory/item_resources/armour/set/knight/knight_gloves.tres",
	"res://gui/inventory/item_resources/armour/set/knight/knight_helmet.tres",
	"res://gui/inventory/item_resources/potions/small/small_curse_potion.tres",
	"res://gui/inventory/item_resources/potions/small/small_hp_potion.tres",
	"res://gui/inventory/item_resources/default_sword.tres",
	"res://gui/inventory/item_resources/long_sword.tres",
]

func _ready() -> void:
	for i in range(INVENTORY_MIN_SIZE):
		var slot := InventorySlot.new()
		
		slot.init(ItemData.Type.MAIN, Vector2(SLOT_SIZE, SLOT_SIZE))
		grid.add_child(slot)
		
	for res_idx in items_to_load.size():
		var item := InventoryItem.new()
		
		item.init(load(items_to_load[res_idx]))
		grid.get_child(res_idx).add_child(item)