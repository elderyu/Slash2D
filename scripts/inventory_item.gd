extends Control
class_name inventory_item
@onready var item_sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if Globals.player_inventory_item_holding != null:
#		item_sprite.position = get_local_mouse_position()
#	pass


#func _on_gui_input(event):
#	print(event)
#	if event is InputEventMouseButton && event.button_index == 1 && event.pressed:
#		if Globals.player_inventory_item_holding != null:
#			print("item clicked")
#			Globals.player_inventory_item_holding = self
#	#		mouse_filter = Control.MOUSE_FILTER_PASS
##			set_deferred("mouse_filter", Control.MOUSE_FILTER_PASS)
#		else:
#			Globals.player_inventory_item_holding = null
#	pass # Replace with function body.
