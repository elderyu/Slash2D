extends Panel
class_name inventory_slot

var item_class = preload("res://scenes/inventory_item.tscn")
var item = null

@onready var inventory_slots = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
#	if randi() % 2 == 0:
#		item = item_class.instantiate()
#		add_child(item)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func slot_item_get():
	remove_child(item)
	var inventory_node = find_parent("inventory")
	inventory_node.add_child(item)
	item = null
	
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
	var inventory_node = find_parent("inventory")
	inventory_node.remove_child(item)
	add_child(item)

func _on_gui_input(event):
	if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
		remove_child(item)
		inventory_slots.add_child(item)
		item = null
#		print("Left mouse click inside Area2D!")
#		var item = get_children().filter(func(c): return c is inventory_item)
#		if item != null && Globals.player_inventory_item_holding == null:
#			print("item clicked")
#			Globals.player_inventory_item_holding = item[0]
#		else:
#			print("place item here")
#			Globals.player_inventory_item_holding.position = position
#
##			add_child(Globals.player_inventory_item_holding)
#			Globals.player_inventory_item_holding = null
	pass
