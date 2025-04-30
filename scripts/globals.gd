extends Node

var player_health_starting = 10 as float
var player_health_current = player_health_starting as float

var player_experience_to_level = 5 as float
var player_experience_current = 0

var player_damage = 1

var points_to_distribute_per_level = 2
var points_to_distribute = 0

var level = 1

var player_inventory_item_holding: inventory_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func find_node_by_name(root: Node, node_name: String) -> Node:
	if root.name == node_name:
		return root

	for child in root.get_children():
		if child is Node:
			var result = find_node_by_name(child, node_name)
			if result:
				return result
	return null
