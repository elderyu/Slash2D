extends Node2D

@onready var ui = %ui
@onready var player = %player
@onready var inventory_chest = $player/inventory_chest
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_chest.visible = false
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		ui.inventory_toggle()
		inventory_chest_toggle()
		
	if Input.is_action_just_pressed("character_sheet"):
		ui.character_sheet_toggle()
		
	if Input.is_action_just_pressed("attack_weapon_1"):
		player.attack_right()
		
	if Input.is_action_just_pressed("attack_weapon_2"):
		player.attack_left()
	
	pass
	
func inventory_chest_toggle():
	inventory_chest.play("close" if inventory_chest.visible else "open")
	inventory_chest.visible = true

func _on_inventory_chest_animation_finished():
	inventory_chest.visible = !(inventory_chest.animation == "close")
	pass # Replace with function body.
