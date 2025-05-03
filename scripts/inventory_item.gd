extends Control
class_name inventory_item

@onready var item_sprite = $Sprite2D
var item_name: String
var item_type: EquipmentType.Type
var item_stack_count: int
var damage_min: int
var damage_max: int
var item_armor: int

var is_equippable: bool
	
func init_from_loot(l: loot):
	item_name = l.item_name
	item_type = l.item_type if l.item_type != null else null
	item_stack_count = l.item_stack_count
	item_sprite.texture = l.sprite.texture
	damage_min = l.damage_min
	damage_max = l.damage_max
	item_armor = l.item_armor
	is_equippable = item_type in EquipmentType.Type.values()
