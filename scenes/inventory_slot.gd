extends Panel
class_name inventory_slot

var item_class = preload("res://scenes/inventory_item.tscn")
var item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		item = item_class.instantiate()
		add_child(item)
	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var equipment_slot_type = null

func slot_item_get():
	remove_child(item)
	var inventory_node = find_parent("ui")
	inventory_node.add_child(item)
	item = null
	if equipment_slot_type != null:
		print("de-equipped item")
	
func slot_item_loot(loot_item: loot):
	var new_item = item_class.instantiate()
	print(loot_item.sprite.texture)
	item = new_item
	add_child(new_item)
	item.position = Vector2(8, 8)
	item.image_set(loot_item.sprite.texture)

func slot_item_put(new_item):
	item = new_item
	item.position = Vector2(8, 8)
	var inventory_node = find_parent("ui")
	inventory_node.remove_child(item)
	add_child(item)
	if equipment_slot_type != null:
		print("equipped item")
