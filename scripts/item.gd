extends Node2D
class_name item

var item_id: int
var item_name: String
var item_stack_count: int = 1
var item_image: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func from_dict(data: Dictionary) -> void:
	item_id = data.get("item_id")
	item_name = data.get("item_name")
	item_image = data.get("item_image")
	item_stack_count = data.get("item_stack_count") if data.has("item_stack_count") else item_stack_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
