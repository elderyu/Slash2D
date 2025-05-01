extends Panel
class_name inventory_slot

var item_class = preload("res://scenes/inventory_item.tscn")
var inv_item: inventory_item
@onready var img_slot = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var equipment_slot_type = null

func slot_item_get():
	remove_child(inv_item)
	var inventory_node = find_parent("ui")
	inventory_node.add_child(inv_item)
	inv_item = null
	if equipment_slot_type != null:
		print("de-equipped item")
	
func slot_item_loot(loot_item: loot):
	var new_item = item_class.instantiate()
	inv_item = new_item
	add_child(new_item)
	inv_item.position = Vector2(8, 8)
	inv_item.init_from_loot(loot_item)

func slot_item_put(new_item):
	inv_item = new_item
	inv_item.position = Vector2(8, 8)
	var inventory_node = find_parent("ui")
	inventory_node.remove_child(inv_item)
	add_child(inv_item)
	print("equipment_slot_type " + str(equipment_slot_type))
	print("item_type " + str(inv_item.item_type))
	if equipment_slot_type != null:
		print("equipped item")
