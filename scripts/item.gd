extends Node2D
class_name item

var item_id: int
var item_name: String
var item_stack_count: int = 1
var item_image: String
var item_type: EquipmentType.Type
var damage_min: int
var damage_max: int

func from_dict(data: Dictionary) -> void:
	item_id = data.get("item_id")
	item_name = data.get("item_name")
	item_image = data.get("item_image")
	item_stack_count = data.get("item_stack_count") if data.has("item_stack_count") else item_stack_count
	item_type = data.get("item_type") if data.has("item_type") else item_type
	damage_min = data.get("damage_min") if data.has("damage_min") else damage_min
	damage_max = data.get("damage_max") if data.has("damage_max") else damage_max
