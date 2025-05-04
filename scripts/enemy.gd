extends CharacterBody2D
class_name enemy

@onready var animation = $animation
@onready var timer_death = $timer_death
@onready var animation_player = $AnimationPlayer
@onready var damage_zone = $damage_zone
var player: player
@onready var collision_body = $collision_body
@onready var experience_label = $experience_label
var ui: ui
@onready var particles = $CPUParticles2D
@onready var slime_sound_damage = $AudioStreamPlayer2D
@onready var slime_sound_death = $AudioStreamPlayer2D2
var weapon_sprite: Sprite2D
var weapon_equipped: loot
@onready var attack_damage_zone = $attack_damage_zone
@onready var timer_attack = $timer_attack
@onready var damage_zone_attack: damage_zone = $damage_zone_attack
@onready var damage_zone_cooldown: Timer = $damage_zone_cooldown

var loot = preload("res://scenes/loot.tscn")

var starting_life: float
var life: float

var blink_count = 10
var current_blink = 0

var is_aggroed = false

var speed_normal = 50
var speed_damaged = 10
var speed_attacking = 50
var speed = speed_normal
var enemy_is_knocked_back = false

var display_name = "Slime"
var guaranteed_item_by_id: int
var is_enemy_damaging_by_body: bool = false
var is_player_in_attack_zone: bool = false

var is_attacking: bool = false

func _on_ready():
	animation_player.play("idle")
	if !is_enemy_damaging_by_body:
		damage_zone.queue_free()
	attack_damage_zone.visible = false
	
func init(data: Dictionary):
	display_name = data.get("name")
	starting_life = data.get("life")
	life = starting_life

func _physics_process(delta):
	if enemy_is_knocked_back:
		move_toward(velocity.x, 0, speed)
		move_toward(velocity.y, 0, speed)
		move_and_collide(velocity * delta)
		enemy_is_knocked_back = false

	if is_aggroed && life > 0 && !is_attacking:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_collide(velocity * delta)

func damage_enemy(_weapon: weapon):
	speed = speed_damaged
	velocity = (position - player.global_position) * 30
	enemy_is_knocked_back = true
	life = life - randi_range(Globals.player_damage_min, Globals.player_damage_max)
	particles.restart()
	particles.emitting = true
	ui.enemy_health_update(self)
	if life <= 0:
		attack_damage_zone.visible = false
		timer_attack.stop()
		ui.enemy_health_hide()
		animation_player.play("death")
		slime_sound_damage.pitch_scale = randf_range(0.8, 1.2)
		slime_sound_death.play()
		if damage_zone != null:
			damage_zone.queue_free()
		collision_body.queue_free()
		$AnimationPlayer2.play("experience_label_show")
		var monster_experience = 1
		ui.ui_experience_gain(monster_experience)
	else:
		animation_player.play("damage_received")
		slime_sound_damage.pitch_scale = randf_range(0.9, 1.1)
		slime_sound_damage.play()

func _on_timer_death_timeout():
	current_blink += 1
	animation.visible = current_blink % 2
	if(current_blink >= blink_count):
		timer_death.queue_free()
		animation.visible = 0
		LootService.generate_loot_by_item_id(guaranteed_item_by_id, global_position)
		queue_free()

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"death":
			timer_death.start()
			return
		"damage_received":
			speed = speed_normal
	animation_player.play("idle")

func _on_collision_aggro_body_entered(body):
	if body is player:
		is_aggroed = true

func _on_health_show_area_mouse_entered():
	if life > 0:
		ui.enemy_health_show(self)

func _on_health_show_area_mouse_exited():
	ui.enemy_health_hide()

func _on_area_attack_range_body_entered(body):
	if body is player:
		attack_start()

func attack_start():
	is_attacking = true
	attack_damage_zone.visible = true
	timer_attack.start()
	attack_damage_zone.play()
	speed = speed_attacking

func _on_timer_attack_timeout():
	attack_damage_zone.visible = false
	attack_damage_zone.stop()
	speed = speed_normal
	is_attacking = false
	damage_zone_attack.damage_player()
	damage_zone_cooldown.start()

func _on_damage_zone_cooldown_timeout():
	if damage_zone_attack.p != null:
		attack_start()
