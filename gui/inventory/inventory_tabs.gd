extends TabContainer

@onready var GRID: Array[Node] = [
	$TabWeapon/ScrollContainer/Grid,
	$TabShield/ScrollContainer/Grid,
	$TabArmour/ScrollContainer/Grid,
	$TabRings/ScrollContainer/Grid,
	$TabCure/ScrollContainer/Grid,
	$TabKeys/ScrollContainer/Grid,
	$TabSpell/ScrollContainer/Grid,
	$TabPiromancy/ScrollContainer/Grid,
	$TabIngredients/ScrollContainer/Grid,
	$TabBooks/ScrollContainer/Grid,
	$TabNotes/ScrollContainer/Grid,
	$TabMisc/ScrollContainer/Grid,
	
]

@onready var TAB_ICONS: Array[Texture2D] = [
	load("res://gui/inventory/tab_icons/weapon.png"),
	load("res://gui/inventory/tab_icons/shield.png"),
	load("res://gui/inventory/tab_icons/armour.png"),
	load("res://gui/inventory/tab_icons/rings.png"),
	load("res://gui/inventory/tab_icons/cure.png"),
	load("res://gui/inventory/tab_icons/keys.png"),
	load("res://gui/inventory/tab_icons/spell.png"),
	load("res://gui/inventory/tab_icons/piromancy.png"),
	load("res://gui/inventory/tab_icons/ingredients.png"),
	load("res://gui/inventory/tab_icons/books.png"),
	load("res://gui/inventory/tab_icons/notes.png"),
	load("res://gui/inventory/tab_icons/misc.png"),
	
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_tabs()

func init_tabs() -> void:
	for idx in range(Game.INVENTORY_TABS.size()):
		set_tab_title(idx, "")
		set_tab_icon(idx, TAB_ICONS[idx])
		tooltip_text = Game.INVENTORY_TABS[idx]
		var grid := GRID[idx]
		
		for i in range(Game.INVENTORY_MIN_SLOTS_COUNT):
			var slot := InventorySlot.new()
			
			slot.init(InventoryData.TYPE.MAIN, Vector2(Game.INVENTORY_SLOT_SIZE, Game.INVENTORY_SLOT_SIZE))
			grid.add_child(slot)


func _on_tab_changed(_tab: int) -> void:
	$"../PanelContainer/MarginContainer/Details/ItemInfo".visible = false
