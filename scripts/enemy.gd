extends CharacterBody2D
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

var loot = preload("res://scenes/loot.tscn")

var starting_life = 3 as float
var life = starting_life as float

var blink_count = 10
var current_blink = 0

var is_aggroed = false

var speed_normal = 50
var speed_damaged = 10
var speed = speed_normal
var enemy_is_knocked_back = false

func _on_ready():
	animation_player.play("idle")
	pass # Replace with function body.
	
func _physics_process(delta):
	if enemy_is_knocked_back:
		move_toward(velocity.x, 0, speed)
		move_toward(velocity.y, 0, speed)
		move_and_collide(velocity * delta)
		enemy_is_knocked_back = false
		
	if is_aggroed && life > 0:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_collide(velocity * delta)
	pass
	
func damage_enemy(weapon: weapon):
	speed = speed_damaged
	velocity = (position - player.global_position) * 30
	enemy_is_knocked_back = true
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
		var loot_instance = loot.instantiate()
		get_parent().add_child(loot_instance)
		print(randi_range(0, Gems.images.size() - 1))
		var gem_index = randi_range(0, Gems.images.size() - 1)
		loot_instance.set_image(Gems.images[gem_index])
		loot_instance.position = position
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
		is_aggroed = true
	pass # Replace with function body.


func _on_health_show_area_mouse_entered():
	ui.enemy_health_toggle(self)
	pass # Replace with function body.


func _on_health_show_area_mouse_exited():
	ui.enemy_health_toggle(self)
	pass # Replace with function body.
