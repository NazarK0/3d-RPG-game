extends Control

@onready var GRID: Array[Node] = [
	$InventoryTabs/TabWeapon/ScrollContainer/Grid,
	$InventoryTabs/TabShield/ScrollContainer/Grid,
	$InventoryTabs/TabArmour/ScrollContainer/Grid,
	$InventoryTabs/TabRings/ScrollContainer/Grid,
	$InventoryTabs/TabCure/ScrollContainer/Grid,
	$InventoryTabs/TabKeys/ScrollContainer/Grid,
	$InventoryTabs/TabSpell/ScrollContainer/Grid,
	$InventoryTabs/TabPiromancy/ScrollContainer/Grid,
	$InventoryTabs/TabIngredients/ScrollContainer/Grid,
	$InventoryTabs/TabBooks/ScrollContainer/Grid,
	$InventoryTabs/TabNotes/ScrollContainer/Grid,
	$InventoryTabs/TabMisc/ScrollContainer/Grid,
	
]

const item_info_panel_path: NodePath = "/root/Inventory/PanelContainer/MarginContainer/Details/ItemInfo"

var items_to_load: Array[String] = [
	"res://gui/inventory/item_resources/armour/set/knight/knight_armour.tres",
	"res://gui/inventory/item_resources/armour/set/knight/knight_boots.tres",
	"res://gui/inventory/item_resources/armour/set/knight/knight_gloves.tres",
	"res://gui/inventory/item_resources/armour/set/knight/knight_helmet.tres",
	"res://gui/inventory/item_resources/potions/small/small_curse_potion.tres",
	"res://gui/inventory/item_resources/potions/small/small_hp_potion.tres",
	"res://gui/inventory/item_resources/default_sword.tres",
	"res://gui/inventory/item_resources/long_sword.tres",
	"res://gui/inventory/item_resources/rings/apostles_set/simon_ring.tres",
	"res://gui/inventory/item_resources/rings/apostles_set/philip_ring.tres",
	"res://gui/inventory/item_resources/rings/apostles_set/john_ring.tres",
]

var items: Array[InventoryItem]

func _ready() -> void:
	items = init_items(items_to_load)
	fillInventory(items, GRID)
	$PanelContainer/MarginContainer/Details/ItemInfo.visible = false

func init_items(items_to_load: Array[String]) -> Array[InventoryItem]:
	var items: Array[InventoryItem]
	
	for res_idx in items_to_load.size():
		var item = InventoryItem.new()
		var item_data = load(items_to_load[res_idx])
		item.init(item_data, item_info_panel_path)
		items.push_back(item)
	
	return items

func displayInventory(group: Array[InventoryItem], grid: Node) -> void:
	for item_idx in range(group.size()):
		grid.get_child(item_idx).add_child(group[item_idx])

func filterInventory(items: Array[InventoryItem], type: InventoryData.TYPE) -> Array[InventoryItem]:
	return items.filter(func(item): return item._data.type == type)

func fillInventory(items: Array[InventoryItem], inventory_grids: Array[Node]) -> void:
	var weapon := filterInventory(items, InventoryData.TYPE.WEAPON)
	var shield := filterInventory(items, InventoryData.TYPE.SHIELD)
	var armour := filterInventory(items, InventoryData.TYPE.ARMOUR)
	var rings := filterInventory(items, InventoryData.TYPE.RING)
	var cure := filterInventory(items, InventoryData.TYPE.CURE)
	var keys := filterInventory(items, InventoryData.TYPE.KEY)
	var spell := filterInventory(items, InventoryData.TYPE.SPELL)
	var piromancy := filterInventory(items, InventoryData.TYPE.PIROMANCY)
	var ingredients := filterInventory(items, InventoryData.TYPE.INGREDIENTS)
	var books := filterInventory(items, InventoryData.TYPE.BOOKS)
	var notes := filterInventory(items, InventoryData.TYPE.NOTES)
	var misc := filterInventory(items, InventoryData.TYPE.MISC)	
	
	displayInventory(weapon, inventory_grids[0])
	displayInventory(shield, inventory_grids[1])
	displayInventory(armour, inventory_grids[2])
	displayInventory(rings, inventory_grids[3])
	displayInventory(cure, inventory_grids[4])
	displayInventory(keys, inventory_grids[5])
	displayInventory(spell, inventory_grids[6])
	displayInventory(piromancy, inventory_grids[7])
	displayInventory(ingredients, inventory_grids[8])
	displayInventory(books, inventory_grids[9])
	displayInventory(notes, inventory_grids[10])
	displayInventory(misc, inventory_grids[11])


