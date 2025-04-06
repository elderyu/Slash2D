extends Control

@onready var chest_close = $chest_close
@onready var chest_open = $chest_open
@onready var inventory_slots = %inventory_slots


var holding_item = null

func _on_ready():
	visible = false
	for i in inventory_slots.get_children():
		i.gui_input.connect(slot_gui_input.bind(i))
	pass # Replace with function body.
	
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func slot_gui_input(event: InputEvent, slot: inventory_slot):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		if holding_item != null:
			if !slot.item:
				slot.slot_item_put(holding_item)
				holding_item = null
			else:
				var temp_item = slot.item
				slot.slot_item_get()
				temp_item.global_position = event.global_position
				slot.slot_item_put(holding_item)
				holding_item = temp_item
		elif slot.item:
			holding_item = slot.item
			slot.slot_item_get()
			holding_item.global_position = get_global_mouse_position()
			
func toggle():
	if visible:
		chest_close.play()
	else:
		chest_open.play()
	visible = !visible
	print("toggle")

