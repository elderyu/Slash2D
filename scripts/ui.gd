extends CanvasLayer
class_name ui

@onready var health_label = %health_label
@onready var health_globe = %health_globe
@onready var inventory = $inventory
@onready var experience_bar = $Control2/experience_bar
@onready var experience_label = $Control2/experience_label
@onready var cs = %character_sheet
@onready var enemy_bar = $enemy_bar
@onready var enemy_bar_health = $label
@onready var inventory_slots = %inventory_slots

@onready var button_increase_damage = %button_increase_damage
@onready var button_increase_health = %button_increase_health
@onready var text_damage = %text_damage
@onready var text_health = %text_health
@onready var text_level = %text_level
@onready var text_armor = %text_armor

@onready var slot_shield = %slot_shield
var player: player
var holding_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	text_damage.text = str(Globals.player_damage_min) + " - " + str(Globals.player_damage_max)
	inventory.visible = false
	cs.visible = false
	enemy_bar.visible = false
	enemy_bar_health.visible = false
	$enemy_name.visible = false
	ui_health_update()
	ui_experience_update()
	%slot_helmet.img_slot.texture = load("res://assets/sprites/inventory_cell_helmet.png")
	%slot_armor.img_slot.texture = load("res://assets/sprites/inventory_cell_armor.png")
	%slot_gloves.img_slot.texture = load("res://assets/sprites/inventory_cell_gloves.png")
	%slot_leggings.img_slot.texture = load("res://assets/sprites/inventory_cell_leggings.png")
	%slot_ring_1.img_slot.texture = load("res://assets/sprites/inventory_cell_ring.png")
	%slot_ring_2.img_slot.texture = load("res://assets/sprites/inventory_cell_ring.png")
	%slot_amulet.img_slot.texture = load("res://assets/sprites/inventory_cell_amulet.png")
	%slot_weapon_1.img_slot.texture = load("res://assets/sprites/inventory_cell_weapon.png")
	slot_shield.img_slot.texture = load("res://assets/sprites/inventory_cell_shield.png")

	%slot_helmet.equipment_slot_type = EquipmentType.Type.HELMET
	%slot_armor.equipment_slot_type = EquipmentType.Type.ARMOR
	%slot_gloves.equipment_slot_type = EquipmentType.Type.GLOVES
	%slot_leggings.equipment_slot_type = EquipmentType.Type.LEGGINGS
	%slot_ring_1.equipment_slot_type = EquipmentType.Type.RING_1
	%slot_ring_2.equipment_slot_type = EquipmentType.Type.RING_2

	%slot_amulet.equipment_slot_type = EquipmentType.Type.AMULET
	%slot_weapon_1.equipment_slot_type = EquipmentType.Type.WEAPON
	slot_shield.equipment_slot_type = EquipmentType.Type.SHIELD

	%button_increase_damage.visible = false
	%button_increase_health.visible = false
	
	for i in inventory_slots.get_children():
		i.gui_input.connect(slot_gui_input.bind(i))

	for i in %equipment_left.get_children():
		i.gui_input.connect(slot_gui_input.bind(i))

	for i in %equipment_right.get_children():
		i.gui_input.connect(slot_gui_input.bind(i))

func init(p: player):
	for i in inventory_slots.get_children():
		i.player = p
		i.ui = self

	for i in %equipment_left.get_children():
		i.player = p
		i.ui = self

	for i in %equipment_right.get_children():
		i.player = p
		i.ui = self
		
func ui_character_update():
	var equipment_list = %equipment_left.get_children() + %equipment_right.get_children()
	Globals.player_armor = 0
	for equipment in equipment_list:
		if equipment.inv_item == null:
			continue
		Globals.player_armor += equipment.inv_item.item_armor		
	ui_health_update()
	text_damage.text = str(Globals.player_damage_min) + " - " + str(Globals.player_damage_max)
	text_armor.text = str(Globals.player_armor)
	# update stats

func ui_health_update():
	health_label.text = str(Globals.player_health_current) + "/" + str(Globals.player_health_starting)
	health_globe.value = Globals.player_health_current/Globals.player_health_starting * 100

func ui_experience_gain(monster_experience):
	Globals.player_experience_current += monster_experience
	ui_experience_update()

func ui_experience_update():
	experience_label.text = str(Globals.player_experience_current) + "/" + str(Globals.player_experience_to_level)
	experience_bar.value = Globals.player_experience_current/Globals.player_experience_to_level * 100

	if Globals.player_experience_current == Globals.player_experience_to_level:
		Globals.player_experience_current = 0
		ui_experience_update()
		Globals.points_to_distribute = Globals.points_to_distribute_per_level
		level_up()

func inventory_toggle():
	if visible:
		%chest_close.play()
	else:
		%chest_open.play()
	inventory.visible = !inventory.visible

func character_sheet_toggle():
	cs.visible = !cs.visible

func enemy_health_show(enemy: enemy):
	enemy_bar_health.visible = true
	enemy_bar.visible = true
	$enemy_name.visible = true
	enemy_health_update(enemy)
	
func enemy_health_hide():
	enemy_bar_health.visible = false
	enemy_bar.visible = false
	$enemy_name.visible = false

func enemy_health_update(enemy: enemy):
	enemy_bar_health.text = str(enemy.life) + "/" + str(enemy.starting_life)
	enemy_bar.value = enemy.life/enemy.starting_life * 100
	$enemy_name.text = enemy.display_name

func slot_gui_input(event: InputEvent, slot: inventory_slot):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		if holding_item != null:
			if !slot.inv_item:
				# put item into slot
				if slot.equipment_slot_type != null && slot.equipment_slot_type != holding_item.item_type:
					return
				slot.slot_item_put(holding_item)
				holding_item = null
				if slot.equipment_slot_type != null:
					ui_character_update()
				slot.item_description.visible = true
				slot.item_description_background.visible = true
			else:
				# swap item between slots
				if slot.equipment_slot_type != null && slot.equipment_slot_type != holding_item.item_type:
					return
				var temp_item = slot.inv_item
				slot.slot_item_get()
				temp_item.global_position = event.global_position
				slot.slot_item_put(holding_item)
				holding_item = temp_item
				if slot.equipment_slot_type != null:
					ui_character_update()
		elif slot.inv_item:
			# get item from slot
			holding_item = slot.inv_item
			slot.slot_item_get()
			if slot.equipment_slot_type != null:
				ui_character_update()

func _input(_event):
	if holding_item:
		inventory.cursor_update(holding_item)

func level_up():
	button_increase_damage.visible = true
	button_increase_health.visible = true
	Globals.level += 1
	text_level.text = str(Globals.level)
	%text_points_to_distribute.text = str(Globals.points_to_distribute)

func handle_point_spent():
	Globals.points_to_distribute -= 1
	%text_points_to_distribute.text = str(Globals.points_to_distribute)
	if Globals.points_to_distribute == 0:
		button_increase_damage.visible = false
		button_increase_health.visible = false

func _on_button_increase_damage_button_down():
	Globals.player_damage_min += 1
	Globals.player_damage_max += 1
	text_damage.text = str(Globals.player_damage_min) + " - " + str(Globals.player_damage_max)
	handle_point_spent()

func _on_button_increase_health_button_down():
	Globals.player_health_starting += 1
	Globals.player_health_current = Globals.player_health_starting
	text_health.text = str(Globals.player_health_starting)

#	ui_health_update()
	health_label.text = str(Globals.player_health_current) + "/" + str(Globals.player_health_starting)
	health_globe.value = Globals.player_health_current/Globals.player_health_starting * 100
	handle_point_spent()
