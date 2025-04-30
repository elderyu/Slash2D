extends Node2D
class_name loot_service

var loot = preload("res://scenes/loot.tscn")

var loot_table = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var loot_table_file = FileAccess.open("res://item_data/loot_table.json", FileAccess.READ)
	loot_table = JSON.parse_string(loot_table_file.get_as_text())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func generate_loot(enemy_position):
	var loot_instance = loot.instantiate()
	add_child(loot_instance)
	print(randi_range(0, Gems.images.size() - 1))
	var gem_index = randi_range(0, Gems.images.size() - 1)
	loot_instance.set_image(Gems.images[gem_index])
	loot_instance.position = enemy_position
