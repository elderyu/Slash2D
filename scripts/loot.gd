extends Node2D
class_name loot

@onready var sprite: Sprite2D = $sprite
@onready var item_description : Label = $NinePatchRect/item_description
var item_name: String
var item_id: int
var item_image: String
var item_class = preload("res://scenes/inventory_item.tscn")
var item_type: EquipmentType.Type
var item_stack_count: int
var damage_min: int
var damage_max: int
var img = null
var item_armor: int

func _on_ready():
	$NinePatchRect.visible = Globals.is_loot_shown
	
func init(data: Dictionary) -> void:
	item_id = data.get("item_id")
	item_name = data.get("item_name")
	item_image = data.get("item_image")
	item_stack_count = data.get("item_stack_count") if data.has("item_stack_count") else item_stack_count
	item_type = data.get("item_type") if data.has("item_type") else item_type
	damage_min = data.get("damage_min") if data.has("damage_min") else damage_min
	damage_max = data.get("damage_max") if data.has("damage_max") else damage_max
	sprite.texture = load("res://assets/sprites/item_icons/" + data.item_image)
	item_armor = data.get("item_armor") if data.has("item_armor") else item_armor

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
			if i.inv_item == null:
				i.slot_item_loot(self)
				break
		visible = false

func _on_area_2d_mouse_entered():
	print("show popup - loot info")

func _on_area_2d_mouse_exited():
	print("hide popup - loot info")

func _on_audio_stream_player_2d_finished():
	queue_free()
	
func label_visibility_change(is_visible: bool):
	$NinePatchRect.visible = is_visible
