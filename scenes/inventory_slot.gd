extends Panel
class_name inventory_slot

var item_class = preload("res://scenes/inventory_item.tscn")
var inv_item = null
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
	print(loot_item.sprite.texture)
	inv_item = new_item
	add_child(new_item)
	inv_item.position = Vector2(8, 8)
	inv_item.image_set(loot_item.sprite.texture)

func slot_item_put(new_item):
	inv_item = new_item
	inv_item.position = Vector2(8, 8)
	var inventory_node = find_parent("ui")
	inventory_node.remove_child(inv_item)
	add_child(inv_item)
	if equipment_slot_type != null:
		print("equipped item")
