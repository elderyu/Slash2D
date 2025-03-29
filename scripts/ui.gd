extends CanvasLayer
class_name ui

@onready var health_label = %health_label
@onready var health_globe = %health_globe
@onready var inventory = $inventory
@onready var experience_bar = $Control2/experience_bar
@onready var experience_label = $Control2/experience_label
@onready var character_sheet: character_sheet = $character_sheet

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.visible = false
	character_sheet.visible = false
	ui_update_health()
	ui_experience_update()
	pass # Replace with function body.
	
func ui_update_health():
	print("test")
	print(health_label.text)
	health_label.text = str(Globals.player_health_current) + "/" + str(Globals.player_health_starting)
	print(health_label.text)
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
		character_sheet.level_up()
		
	
func inventory_toggle():
	inventory.visible = !inventory.visible
	
func character_sheet_toggle():
	character_sheet.visible = !character_sheet.visible
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
