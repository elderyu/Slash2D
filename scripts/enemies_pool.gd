extends Node

var enemies_table: Array[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready():	
	var enemies = FileAccess.open("res://data/enemies/enemy.json", FileAccess.READ)
	enemies = JSON.parse_string(enemies.get_as_text())
	for enemy_from_table in enemies:
		enemies_table.append(enemy_from_table)
