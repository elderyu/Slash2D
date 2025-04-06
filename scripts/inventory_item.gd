extends Control
class_name inventory_item

@onready var item_sprite = $Sprite2D

var is_stackable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func image_set(texture):
	item_sprite.texture = texture
