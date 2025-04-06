extends Node2D
class_name weapon

@onready var animation_player = $AnimationPlayer
@onready var sound_swoosh = $AudioStreamPlayer2D

var weapon_equipped: Sprite2D = null

func attack(weapon: Sprite2D):
	visible = true
	weapon_equipped = weapon
	weapon_equipped.hide()
	sound_swoosh.pitch_scale = randf_range(0.9, 1.1)
	animation_player.play("attack")
	

func _on_animation_player_animation_finished(anim_name):
	weapon_equipped.show()
	visible = false
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body is enemy and visible:
		var enemy = body as enemy
		enemy.damage_enemy(self)
	pass # Replace with function body.
