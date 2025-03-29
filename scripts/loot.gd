extends Node2D

@onready var sprite: Sprite2D = $sprite

func set_image(image):
	sprite.texture = load(image)
	
func get_loot():
	queue_free()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()
	pass # Replace with function body.
