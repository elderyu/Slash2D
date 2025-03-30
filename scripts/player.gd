extends CharacterBody2D
class_name player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var collision = $CollisionShape2D
@onready var death_timer = $Timer
@onready var ui = $"../ui"
@onready var timer_attack = $timer_attack
@onready var animation_player = $AnimationPlayer
@onready var weapon_on_back_right = $weapon_on_back_right
@onready var weapon_on_back_left = $weapon_on_back_left
@onready var player_sprite = $AnimatedSprite2D
@onready var weapon_right = $weapon_right
@onready var weapon_left = $weapon_left

var middle_of_the_body = Vector2(0, -8)
var is_attacking_weapon_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling_gravity = gravity * 1.5

func _ready():
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx = Input.get_axis("move_left", "move_right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directiony = Input.get_axis("move_up", "move_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if directionx < 0:
		player_sprite.flip_h = true
	elif directionx > 0:
		player_sprite.flip_h = false
	
	move_and_collide(velocity * delta)

func attack_right():
	print("attack right")
	
	var mouse_position = get_local_mouse_position()
	var vector = mouse_position - middle_of_the_body
	var vector1 = vector.normalized() * 1
	weapon_right.position = vector1 + middle_of_the_body
	weapon_right.rotation = vector.angle() + 3.14/4
	weapon_right.attack(weapon_on_back_right)
	
func attack_left():
	print("attack left")
	var mouse_position = get_local_mouse_position()
	var vector = mouse_position - middle_of_the_body
	var vector1 = vector.normalized() * 1
	weapon_left.position = vector1 + middle_of_the_body
	weapon_left.rotation = vector.angle() + 3.14/4
	weapon_left.attack(weapon_on_back_left)

func damage_player(damage_zone: damage_zone):
	Globals.player_health_current = Globals.player_health_current - 1
	
	ui.ui_update_health()
#	print(damage_zone.global_position)
	velocity = (position - damage_zone.global_position).normalized() * 1000 * 1# Vector2(-500, 0)
	print(velocity)

	if Globals.player_health_current <= 0:
		Engine.time_scale = 0.5
		print("You died!")
		death_timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	Globals.player_health_current = Globals.player_health_starting
	get_tree().reload_current_scene()

func _on_weapon_collider_area_entered(area):
	if area is enemy and is_attacking_weapon_right:
		var enemy = area as enemy
		enemy.damage_enemy()
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name):
	is_attacking_weapon_right = !is_attacking_weapon_right
	weapon_on_back_right.show()
	pass # Replace with function body.
