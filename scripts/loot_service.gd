extends Node2D
class_name loot_service

var loot = preload("res://scenes/loot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_loot(position):
	var loot_instance = loot.instantiate()
	add_child(loot_instance)
	print(randi_range(0, Gems.images.size() - 1))
	var gem_index = randi_range(0, Gems.images.size() - 1)
	
	loot_instance.set_image(Gems.images[gem_index])
	loot_instance.position = position
