extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var sound_swoosh = $AudioStreamPlayer2D

var weapon_equipped: Sprite2D = null

func attack(weapon: Sprite2D):
	visible = true
	print("attack with weapon")
	weapon_equipped = weapon
	weapon_equipped.hide()
	sound_swoosh.pitch_scale = randf_range(0.9, 1.1)
	animation_player.play("attack")
	

func _on_animation_player_animation_finished(anim_name):
	weapon_equipped.show()
	visible = false
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area is enemy and visible:
		var enemy = area as enemy
		enemy.damage_enemy()
	pass # Replace with function body.
