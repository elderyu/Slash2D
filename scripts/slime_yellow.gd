extends enemy

const SPEED_CHARGE: float = 400.0

var charge_frames_count: int = 10
var charge_frames_current_count: int = -1
var player_position_to_charge: Vector2

func attack_start():
	is_attacking = true
	attack_damage_zone.visible = true
	timer_attack.start()
	attack_damage_zone.play()
	speed = 0
	var vector_charge = player.position - position
	attack_damage_zone.rotation = vector_charge.angle()
	attack_damage_zone.position.x = vector_charge.x
	attack_damage_zone.position.y = vector_charge.y
	player_position_to_charge = player.position
	
func _on_timer_attack_timeout():
	attack_damage_zone.visible = false
	attack_damage_zone.stop()
	speed = SPEED_CHARGE
	is_attacking = false
	charge_frames_current_count = charge_frames_count
#	damage_zone_attack.damage_player()
#	damage_zone_cooldown.start()

func _physics_process(delta):
	if charge_frames_current_count >= 0:
		charge_frames_current_count -= 1
		move_toward(player_position_to_charge.x, 0, speed)
		move_toward(player_position_to_charge.y, 0, speed)
		move_and_collide(velocity * delta)
		if charge_frames_current_count == 0:
			speed = speed_normal
			if damage_zone_attack.p != null:
				attack_start()
		
	if enemy_is_knocked_back:
		move_toward(velocity.x, 0, speed)
		move_toward(velocity.y, 0, speed)
		move_and_collide(velocity * delta)
		enemy_is_knocked_back = false

	if is_aggroed && life > 0:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_collide(velocity * delta)
