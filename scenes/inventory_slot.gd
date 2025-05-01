extends Panel
class_name inventory_slot

var item_class = preload("res://scenes/inventory_item.tscn")
var inv_item: inventory_item
@onready var item_description = $item_description
@onready var item_description_background = $item_description_background
@onready var img_slot = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	item_description.visible = inv_item != null
	item_description_background.visible = inv_item != null
	pass

var equipment_slot_type = null

func slot_item_get():
	remove_child(inv_item)
	var inventory_node = find_parent("ui")
	inventory_node.add_child(inv_item)
	inv_item = null
	if equipment_slot_type != null:
		print("todo unequip item - adjust statistics")
	
func slot_item_loot(loot_item: loot):
	var new_item = item_class.instantiate()
	inv_item = new_item
	add_child(new_item)
	inv_item.position = Vector2(8, 8)
	inv_item.init_from_loot(loot_item)
	item_description_set(inv_item)

func slot_item_put(new_item):
	inv_item = new_item
	inv_item.position = Vector2(8, 8)
	var inventory_node = find_parent("ui")
	inventory_node.remove_child(inv_item)
	add_child(inv_item)
	item_description_set(inv_item)
	if equipment_slot_type != null:
		print("todo equip item - adjust statistics")

func item_description_set(inv_item: inventory_item):
	$item_description/item_name.text = inv_item.item_name

func _on_mouse_entered():
	if inv_item == null:
		return
	item_description.visible = true
	item_description_background.visible = true
	pass # Replace with function body.


func _on_mouse_exited():
	item_description.visible = false
	item_description_background.visible = false
	pass # Replace with function body.
