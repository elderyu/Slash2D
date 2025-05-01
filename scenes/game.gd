extends Node2D

@onready var ui = %ui
@onready var player = %player
@onready var inventory_chest = $player/inventory_chest

var enemy_class = preload("res://scenes/enemy.tscn")

var are_enemies_spawned = false

var number_of_enemies_to_spawn = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$ui.visible = true
	inventory_chest.visible = false
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	call_deferred("spawn_enemies")

func spawn_enemies():
	for i in range (number_of_enemies_to_spawn):
		var enemy_spawned = enemy_class.instantiate()
		enemy_spawned.player = %player
		enemy_spawned.ui = %ui
		enemy_spawned.loot_service = %loot_service
		
		var weapon_sprite = ""
		match randi()%3:
			1:
				weapon_sprite = "res://assets/sprites/sword_a_3.png"
			2:	
				weapon_sprite = "res://assets/sprites/spear1.png"
		enemy_spawned.weapon_sprite = weapon_sprite
		add_child(enemy_spawned)
		var extents = $spawn_area/spawn_area_rectangle.shape.extents
		var spawn_area_rectangle_global_position = $spawn_area/spawn_area_rectangle.global_position
		var randx = randi_range(-extents.x, extents.x)
		var randy = randi_range(-extents.y, extents.y)
		spawn_area_rectangle_global_position.x += randx
		spawn_area_rectangle_global_position.y += randy
		enemy_spawned.position = spawn_area_rectangle_global_position
		
##		var local_pos = tilemap.to_local(Vector2(100, 100))
#		print(tileMap.get_cell_source_id(0, enemy_spawned.global_position))
#
#		var cell_coords = tileMap.local_to_map(enemy_spawned.position)
#
#		# Get tile data
#		var tile_data = tileMap.get_cell_tile_data(0, cell_coords)  # 0 = layer index
#		print()
#		if tile_data:
#			print(tile_data)
##			return {
##				"tile_coords": cell_coords,
##				"tile_id": tile_data.get_tile_id(),
##				"source_id": tile_data.get_source_id()
##			}
#		else:
#			print("no tile found")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		ui.inventory_toggle()
		inventory_chest_toggle()

	if Input.is_action_just_pressed("character_sheet"):
		ui.character_sheet_toggle()

	if Input.is_action_just_pressed("attack_weapon_1"):
		player.attack_right()

	if Input.is_action_just_pressed("attack_weapon_2"):
		player.attack_left()
		LootService.generate_loot_by_item_id(2, 3, player.global_position)
		
	if Input.is_action_just_pressed("loot_show"):
		loot_show()
		
	if Input.is_action_just_pressed("debug_print_tree_pretty"):	
		print_tree_pretty()

func inventory_chest_toggle():
	inventory_chest.play("close" if inventory_chest.visible else "open")
	inventory_chest.visible = true

func _on_inventory_chest_animation_finished():
	inventory_chest.visible = !(inventory_chest.animation == "close")
	
func loot_show():
	var nodes = get_children()
	Globals.is_loot_shown = !Globals.is_loot_shown
	for node in nodes:
		if node is loot:
			var loot = node as loot
			print(loot.item_name)
			loot.label_visibility_change(Globals.is_loot_shown)
