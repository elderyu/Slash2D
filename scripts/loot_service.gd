extends Node2D
class_name loot_service

var loot = preload("res://scenes/loot.tscn")
var items_table: Array[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready():	
	var items = FileAccess.open("res://item_data/items.json", FileAccess.READ)
	items = JSON.parse_string(items.get_as_text())
	for item_from_table in items:
		items_table.append(item_from_table)
	pass

func generate_loot_by_item_id(id: int, position_spawn: Vector2):
	if(id == 0):
		return
	var item_to_generate = loot.instantiate()
	var item_data = items_table.filter(func(i: Dictionary): return i.item_id == id)[0]
	get_tree().current_scene.add_child(item_to_generate)
	item_to_generate.init(item_data)
	item_to_generate.global_position = position_spawn

func get_items_by_ids(ids: Array[int]):
	var items_to_return: Array[loot]
	for i in items_table:
		for id in ids:
			if i.item_id == id:
				items_to_return.append(i)
	return items_to_return
