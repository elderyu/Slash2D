extends Node2D
class_name loot

@onready var sprite: Sprite2D = $sprite
@onready var item_name = $NinePatchRect/item_name
var item_class = preload("res://scenes/inventory_item.tscn")

var img = null

func _on_ready():
	pass
#	item_name.visible = false

func set_image(image):
	sprite.texture = load(image)
	img = image

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$AudioStreamPlayer2D.play()
		print("loot")
		print(Globals.find_node_by_name(get_parent(), "inventory_slots"))
		var inventory_slots = Globals.find_node_by_name(get_parent(), "inventory_slots").get_children()
		for i in inventory_slots:
			if i.item == null:
				i.slot_item_loot(self)
				break
		visible = false

func _on_area_2d_mouse_entered():
	print("show popup - loot info")
#	item_name.visible = true

func _on_area_2d_mouse_exited():
	print("hide popup - loot info")
#	item_name.visible = false


func _on_audio_stream_player_2d_finished():
	queue_free()
	pass # Replace with function body.
