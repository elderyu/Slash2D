extends Area2D
class_name spawn_area

var enemy_class = preload("res://scenes/enemy.tscn")
@onready var spawn_area_rectangle = $CollisionShape2D

@export var number_of_enemies_to_spawn: int = 1
@export var guaranteed_item_by_id: int = 0

func spawn_enemies():
	for i in range (number_of_enemies_to_spawn):
		var enemy_id = randi_range(1, 2) 
		var enemy_data = EnemiesPool.enemies_table.filter(func(e: Dictionary): return e.id == enemy_id)[0]
		var enemy_spawned = enemy_class.instantiate()
		enemy_spawned.player = %player
		enemy_spawned.ui = %ui
		
		get_parent().add_child(enemy_spawned)
		enemy_spawned.init(enemy_data)
		var extents = spawn_area_rectangle.shape.extents
		var spawn_area_rectangle_global_position = spawn_area_rectangle.global_position
		var randx = randi_range(-extents.x, extents.x)
		var randy = randi_range(-extents.y, extents.y)
		spawn_area_rectangle_global_position.x += randx
		spawn_area_rectangle_global_position.y += randy
		enemy_spawned.global_position = spawn_area_rectangle_global_position
		enemy_spawned.guaranteed_item_by_id = guaranteed_item_by_id
