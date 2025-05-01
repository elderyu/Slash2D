extends Control
class_name inventory_item

@onready var item_sprite = $Sprite2D
var item_name: String
var item_type: EquipmentType.Type
var item_stack_count: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func init_from_loot(l: loot):
	item_name = l.item_name.text
	item_type = l.item_type if l.item_type != null else null
	item_stack_count = l.item_stack_count
	item_sprite.texture = l.sprite.texture
