extends Area2D
class_name damage_zone

var p: player

func _on_body_entered(body):
	if body is player:
		p = body as player

func damage_player():
	if p != null:
		p.damage_player(self)

func _on_body_exited(body):
	if body is player:
		p = null
