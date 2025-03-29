extends Control
class_name character_sheet

@onready var button_increase_damage = $NinePatchRect/HBoxContainer/VBoxContainer3/button_increase_damage
@onready var button_increase_health = $NinePatchRect/HBoxContainer/VBoxContainer3/button_increase_health
@onready var text_damage = $NinePatchRect/HBoxContainer/VBoxContainer2/text_damage
@onready var text_health = $NinePatchRect/HBoxContainer/VBoxContainer2/text_health
@onready var text_level = $NinePatchRect/HBoxContainer/VBoxContainer2/text_level
@onready var health_globe = %health_globe
@onready var health_label = %health_label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func level_up():
	button_increase_damage.visible = true
	button_increase_health.visible = true
	Globals.level += 1
	text_level.text = str(Globals.level)

func _on_button_increase_health_pressed():
	Globals.player_health_starting += 1
	Globals.player_health_current = Globals.player_health_starting
	text_health.text = str(Globals.player_health_starting)

	health_label.text = str(Globals.player_health_current) + "/" + str(Globals.player_health_starting)
	health_globe.value = Globals.player_health_current/Globals.player_health_starting * 100
	pass # Replace with function body.


func _on_button_increase_damage_pressed():
	Globals.player_damage += 1
	text_damage.text = str(Globals.player_damage)
	
	handle_point_spent()
	pass # Replace with function body.
	
func handle_point_spent():
	Globals.points_to_distribute -= 1
	if Globals.points_to_distribute == 0:
		button_increase_damage.visible = false
		button_increase_health.visible = false
