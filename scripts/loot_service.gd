extends Node2D
class_name loot_service

var loot = preload("res://scenes/loot.tscn")

var loot_table = null
var items_table: Array[item]

# Called when the node enters the scene tree for the first time.
func _ready():
	var loot_table_file = FileAccess.open("res://item_data/loot_table.json", FileAccess.READ)
	loot_table = JSON.parse_string(loot_table_file.get_as_text())
	
	var items = FileAccess.open("res://item_data/items.json", FileAccess.READ)
	items = JSON.parse_string(items.get_as_text())
	for item_from_table in items:
		var item_new = item.new()
		item_new.from_dict(item_from_table)
		items_table.append(item_new)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func generate_loot_by_enemy(enemy: enemy):
	print("loot generate")
	print(enemy.display_name)

func generate_loot_by_item_id(id: int, amount: int, position_spawn: Vector2):
	var loot_instance = loot.instantiate() as loot
	get_tree().current_scene.add_child(loot_instance)
	var item_to_generate = items_table.filter(func(i: item): return i.item_id == id)[0]
	loot_instance.item_name.text = item_to_generate.item_name
	loot_instance.global_position = position_spawn
	loot_instance.set_image("res://assets/sprites/item_icons/" + item_to_generate.item_image)
