extends Node2D
class_name loot

@onready var sprite: Sprite2D = $sprite

var item_class = preload("res://scenes/inventory_item.tscn")

var img = null

func set_image(image):
	sprite.texture = load(image)
	img = image
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print(Globals.find_node_by_name(get_parent(), "inventory_slots"))
		var inventory_slots = Globals.find_node_by_name(get_parent(), "inventory_slots").get_children()
		for i in inventory_slots:
			if i.item == null:
#				var item = item_class.instantiate()
#				add_child(item)
#				item.image_set(img)
				i.slot_item_loot(self)
				break
		queue_free()
	pass # Replace with function body.
