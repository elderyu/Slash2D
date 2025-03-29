extends Area2D
class_name enemy

@onready var animation = $animation
@onready var timer_death = $timer_death
@onready var animation_player = $AnimationPlayer
@onready var damage_zone = $damage_zone
@onready var player = %player
@onready var collision_body = $collision_body
@onready var experience_label = $experience_label
@onready var ui: ui = %ui
@onready var loot_service: loot_service = %loot_service
@onready var particles = $CPUParticles2D
@onready var slime_sound_damage = $AudioStreamPlayer2D
@onready var slime_sound_death = $AudioStreamPlayer2D2

var starting_life = 10
var life = starting_life

var blink_count = 10
var current_blink = 0

var is_aggroed = false

var speed_normal = 50
var speed_damaged = 10
var speed = speed_normal

func _on_ready():
	animation_player.play("idle")
	pass # Replace with function body.
	
func _process(delta):
	if is_aggroed && !(life <= 0):
		var direction = (player.position - position).normalized()
		position += direction * speed * delta
	pass
	
func damage_enemy():
	speed = speed_damaged
	life = life - Globals.player_damage
	particles.restart()
	particles.emitting = true
	if life <= 0:
		animation_player.play("death")
		slime_sound_damage.pitch_scale = randf_range(0.8, 1.2)
		slime_sound_death.play()
		damage_zone.queue_free()
		collision_body.queue_free()
	else:
		animation_player.play("damage_received")
		slime_sound_damage.pitch_scale = randf_range(0.9, 1.1)
		slime_sound_damage.play()

func _on_animation_death_animation_finished():
	timer_death.start()
	pass # Replace with function body.

func _on_timer_death_timeout():
	current_blink += 1
	animation.visible = current_blink % 2
	
	if(current_blink >= blink_count):
		timer_death.queue_free()
		experience_label.visible = 1
		animation_player.play("experience_label_show")
		animation.visible = 0
		var monster_experience = 1
		ui.ui_experience_gain(monster_experience)
		loot_service.generate_loot(position)
	
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"death":
			timer_death.start()
			return
		"damage_received":
			speed = speed_normal
		"experience_label_show":
			queue_free()
		
	animation_player.play("idle")
	pass # Replace with function body.

func _on_collision_aggro_body_entered(body):
	print(body)
	if body is player:
		var p = body as player
		print(p.position)
		is_aggroed = true
	pass # Replace with function body.
