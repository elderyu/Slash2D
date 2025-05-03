extends Node2D

@onready var ui = %ui
@onready var player = %player
@onready var inventory_chest = $player/inventory_chest

var enemy_class = preload("res://scenes/enemy.tscn")

var are_enemies_spawned = false

var number_of_enemies_to_spawn = 1
var is_ui_opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ui.visible = true
	inventory_chest.visible = false
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	call_deferred("init")

func init():
	for i in range(LootService.items_table.size()):
		LootService.generate_loot_by_item_id(i, player.global_position)
	var spawn_areas = get_children().filter(func(c): return c is spawn_area)
	ui.init(player)
	for spawn_area_item in spawn_areas:
		var a = spawn_area_item as spawn_area
		a.spawn_enemies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
#		is_ui_opened = !is_ui_opened
		ui.inventory_toggle()
		inventory_chest_toggle()

	if Input.is_action_just_pressed("character_sheet"):
#		is_ui_opened = !is_ui_opened
		ui.character_sheet_toggle()

	if Input.is_action_just_pressed("attack_weapon_1"):
#		if is_ui_opened:
#			return
		player.attack_right()

	if Input.is_action_just_pressed("attack_weapon_2"):
#		player.attack_left()
		LootService.generate_loot_by_item_id(5, player.global_position)
		LootService.generate_loot_by_item_id(1, player.global_position)
		
	if Input.is_action_just_pressed("loot_show"):
		loot_show()
		
	if Input.is_action_just_pressed("debug_print_tree_pretty"):
		print_tree_pretty()
		LootService.generate_loot_by_item_id(6, player.global_position)
		
	if Input.is_action_just_pressed("dodge"):
		player.dodge()

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
			loot.label_visibility_change(Globals.is_loot_shown)
