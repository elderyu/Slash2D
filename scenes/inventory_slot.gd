extends Panel
class_name inventory_slot

var item_class = preload("res://scenes/inventory_item.tscn")
var inv_item: inventory_item
@onready var item_description = $item_description
@onready var item_description_background = $item_description_background
@onready var img_slot = $Sprite2D
var equipment_slot_type = null
var player: player
var ui: ui
@onready var item_armor = $item_description/item_armor
@onready var item_damage = $item_description/item_damage
@onready var item_equip_info = $item_description/item_equip_info

# Called when the node enters the scene tree for the first time.
func _ready():
	item_description.visible = inv_item != null
	item_description_background.visible = inv_item != null

func slot_item_get():
	item_description.visible = false
	item_description_background.visible = false
	remove_child(inv_item)
	var inventory_node = find_parent("ui")
	inventory_node.add_child(inv_item)
	inv_item = null
	if equipment_slot_type != null:
		print("todo unequip item - adjust statistics")
	if equipment_slot_type == EquipmentType.Type.WEAPON:
		player.weapon_right_unequip()
		Globals.player_damage_min = 0
		Globals.player_damage_max = 0
		ui.ui_character_update()
	
func slot_item_loot(loot_item: loot):
	var new_item = item_class.instantiate()
	inv_item = new_item
	add_child(new_item)
	inv_item.position = Vector2(8, 8)
	inv_item.init_from_loot(loot_item)
	item_description_set()

func slot_item_put(new_item):
	inv_item = new_item
	inv_item.position = Vector2(8, 8)
	var inventory_node = find_parent("ui")
	inventory_node.remove_child(inv_item)
	add_child(inv_item)
	item_description_set()
	if equipment_slot_type == EquipmentType.Type.WEAPON:
		player.weapon_right_equip(inv_item.item_sprite)
		Globals.player_damage_min = inv_item.damage_min
		Globals.player_damage_max = inv_item.damage_max
	if equipment_slot_type != null:
		print("todo equip item - adjust statistics")
		ui.ui_character_update()
	
func item_description_set():
	$item_description/item_name.text = inv_item.item_name
	# todo display better?
	if inv_item.item_armor != 0:
		item_armor.text = "Armor: " + str(inv_item.item_armor)
	else:
		item_armor.visible = false
	if inv_item.item_type == EquipmentType.Type.WEAPON:
		item_damage.text = "Damage: " + str(inv_item.damage_min) + " - " + str(inv_item.damage_max)
	else:
		item_damage.visible = false
	if !inv_item.is_equippable:
		item_equip_info.visible = false

func _on_mouse_entered():
	if ui.holding_item != null:
		return
	if inv_item == null:
		return
	item_description.visible = true
	item_description_background.visible = true


func _on_mouse_exited():
	item_description.visible = false
	item_description_background.visible = false
