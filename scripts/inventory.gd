extends Control

@onready var chest_close = $chest_close
@onready var chest_open = $chest_open

func _on_ready():
	visible = false
	pass # Replace with function body.

func toggle():
	if visible:
		chest_close.play()
	else:
		chest_open.play()
	visible = !visible
	print("toggle")
	
	
	
#@onready var inventory_grid = $Inventory/GridContainer
#@onready var character_slots = $CharacterSheet/Slots
#
#var inventory_size = Vector2(10, 5)  # 10x5 grid
#var inventory = []  # Stores item data
#var dragging_item = null  # Currently dragged item
#
#func _ready():#	initialize_inventory()
#
#func initialize_inventory():
#	inventory.resize(inventory_size.x * inventory_size.y)
#	for i in range(inventory.size()):
#		inventory[i] = null  # Empty slots
#	update_inventory_ui()
#
#func update_inventory_ui():
#	for i in inventory_grid.get_children():
#		i.queue_free()
#
#	for i in range(inventory.size()):
#		var slot = Button.new()
#		slot.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#		slot.size_flags_vertical = Control.SIZE_EXPAND_FILL
#		slot.connect("pressed", _on_slot_pressed.bind(i))
#		inventory_grid.add_child(slot)
#
#		if inventory[i]:
#			var item_texture = TextureRect.new()
#			item_texture.texture = inventory[i]["texture"]
#			item_texture.expand_mode = TextureRect.EXPAND_FIT
#			slot.add_child(item_texture)
#
#func _on_slot_pressed(slot_index):
#	if dragging_item:
#		place_item(slot_index)
#	elif inventory[slot_index]:
#		pick_up_item(slot_index)
#
#func pick_up_item(slot_index):
#	dragging_item = inventory[slot_index]
#	inventory[slot_index] = null
#	update_inventory_ui()
#
#func place_item(slot_index):
#	inventory[slot_index] = dragging_item
#	dragging_item = null
#	update_inventory_ui()
#
#func equip_item(slot_index, equip_slot):
#	if inventory[slot_index]:
#		character_slots[equip_slot] = inventory[slot_index]
#		inventory[slot_index] = null
#		update_inventory_ui()
#		update_character_ui()
#
#func update_character_ui():
#	for slot in character_slots.get_children():
#		slot.queue_free()
#	for key in character_slots:
#		if character_slots[key]:
#			var item_texture = TextureRect.new()
#			item_texture.texture = character_slots[key]["texture"]
#			character_slots[key].add_child(item_texture)


