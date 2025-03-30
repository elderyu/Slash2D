extends Area2D
class_name damage_zone

@onready var timer_damage_cooldown = $timer_damage_cooldown

var is_attack_ready = true
var is_player_in_hitbox = false
var p = ""

func _on_body_entered(body):
	print(body)
	if body is player:
		p = body as player
		damage_player()
		
func damage_player():
	if is_attack_ready:
		p.damage_player(self)
		is_attack_ready = false
		is_player_in_hitbox = true
		timer_damage_cooldown.start()

func _on_timer_damage_cooldown_timeout():
	print("strike again")
	is_attack_ready = true
	if is_player_in_hitbox:
		damage_player()
	pass # Replace with function body.

func _on_body_exited(body):
	is_player_in_hitbox = false
	is_attack_ready = true
	pass # Replace with function body.
