extends CharacterBody2D
class_name player

const SPEED_DODGE = 300.0
const SPEED_NORMAL = 80.0
var speed = SPEED_NORMAL

@onready var collision = $CollisionShape2D
@onready var death_timer = $Timer
@onready var timer_attack = $timer_attack
@onready var animation_player = $AnimationPlayer
@onready var weapon_on_back_right = $weapon_on_back_right
@onready var weapon_on_back_left = $weapon_on_back_left
@onready var player_sprite = $AnimatedSprite2D
var weapon_right: weapon
var weapon_left: weapon
@onready var particles = $CPUParticles2D
@onready var sound_player_damage = $sound_player_damage
@onready var sound_player_death = $sound_player_death
@onready var ui = %ui

var middle_of_the_body = Vector2(0, -8)
var is_attacking_weapon_right = false
var player_is_knocked_back: bool = false
var damage_zone_position = null

var knockback = 500
var is_performing_dodge = false
var dodge_frame_count = 15
var dodge_frame_current_count = 15

func _physics_process(delta):
	if is_performing_dodge:
		dodge_frame_current_count -= 1
		if dodge_frame_current_count == 0:
			is_performing_dodge = false
			speed = SPEED_NORMAL
			dodge_frame_current_count = dodge_frame_count
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if player_is_knocked_back:
		move_toward(velocity.x, 0, speed)
		move_toward(velocity.y, 0, speed)
		move_and_collide(velocity * delta)
		player_is_knocked_back = false
		return
	
	var directionx = Input.get_axis("move_left", "move_right")
	if directionx:
		velocity.x = directionx * speed
	else:
		if !is_performing_dodge:
			velocity.x = move_toward(velocity.x, 0, speed)

	var directiony = Input.get_axis("move_up", "move_down")
	if directiony:
		velocity.y = directiony * speed
	else:
		if !is_performing_dodge:
			velocity.y = move_toward(velocity.y, 0, speed)

	if directionx < 0:
		player_sprite.flip_h = true
	elif directionx > 0:
		player_sprite.flip_h = false

	move_and_slide()
#	move_and_collide(velocity * delta)

func attack_right():
	if weapon_right == null:
		return
	var mouse_position = get_local_mouse_position()
	var vector = mouse_position - middle_of_the_body
	var vector1 = vector.normalized() * 1
	weapon_right.position = vector1 + middle_of_the_body
	weapon_right.rotation = vector.angle() + 3.14/4
	weapon_right.attack(weapon_on_back_right)

func attack_left():
	var mouse_position = get_local_mouse_position()
	var vector = mouse_position - middle_of_the_body
	var vector1 = vector.normalized() * 1
	weapon_left.position = vector1 + middle_of_the_body
	weapon_left.rotation = vector.angle() + 3.14/4
	weapon_left.attack(weapon_on_back_left)

func damage_player(damage_zone: damage_zone):
	Globals.player_health_current = Globals.player_health_current - 1

	ui.ui_health_update()
	player_is_knocked_back = true
	damage_zone_position = damage_zone.global_position
	velocity = (position - damage_zone_position).normalized() * knockback * 1
	particles.restart()
	particles.emitting = true
	if Globals.player_health_current > 0:
		sound_player_damage.pitch_scale = randf_range(0.7, 1.3)
		sound_player_damage.play()

	if Globals.player_health_current <= 0:
		sound_player_death.play()
		Engine.time_scale = 0.5
		death_timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	Globals.player_health_current = Globals.player_health_starting
	get_tree().reload_current_scene()

func _on_animation_player_animation_finished(_anim_name):
	is_attacking_weapon_right = !is_attacking_weapon_right
	weapon_on_back_right.show()
	
func weapon_right_unequip():
	weapon_on_back_right.texture = null
	weapon_right.queue_free()

func weapon_right_equip(sprite: Sprite2D):
	weapon_on_back_right.texture = sprite.texture
	weapon_right = PreloadScriptPaths.PRELOAD_WEAPON.instantiate()
	add_child(weapon_right)
	weapon_right.item_sprite.texture = sprite.texture
	
func dodge():
	speed = SPEED_DODGE
	is_performing_dodge = true
