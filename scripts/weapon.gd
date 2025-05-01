extends item
class_name weapon

@onready var animation_player = $AnimationPlayer
@onready var sound_swoosh = $AudioStreamPlayer2D

var weapon_equipped: Sprite2D = null

func _ready():
	$item/Area2D/CollisionShape2D.disabled = true
	visible = false

func attack(weapon: Sprite2D):
	$item/Area2D/CollisionShape2D.disabled = false
	weapon_equipped = weapon
	weapon_equipped.hide()
	sound_swoosh.pitch_scale = randf_range(0.9, 1.1)
	visible = true
	animation_player.play("attack")


func _on_animation_player_animation_finished(_anim_name):
	weapon_equipped.show()
	visible = false
	$item/Area2D/CollisionShape2D.disabled = true
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body is enemy and visible:
		var enemy = body as enemy
		enemy.damage_enemy(self)

func _on_area_2d_area_entered(area):
	print(area)
	if area is lever:
		var lever = area as lever
		lever.switch()
