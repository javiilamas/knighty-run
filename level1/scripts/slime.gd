extends Node2D

# Constants
const SPEED = 40
var direction = 1
var can_kill = false

# Node references
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var kill_zone: Area2D = $"kill zone"
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D_right
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D_left
@onready var ray_cast_floor_right: RayCast2D = $RayCast2D_floor_right
@onready var ray_cast_floor_left: RayCast2D = $RayCast2D_floor_left


func _ready():
	# Connect to detect when player touches the slime
	kill_zone.body_entered.connect(_on_body_entered)
	
	# Enable killing after short delay
	await get_tree().create_timer(0.2).timeout
	can_kill = true


func _process(delta):
	# --- Removed player tracking logic ---

	# Change direction if hitting a wall
	if ray_cast_2d_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	elif ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true

	# Change direction if there's no floor ahead
	if direction == 1 and not ray_cast_floor_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	elif direction == -1 and not ray_cast_floor_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false

	# Move slime
	position.x += direction * SPEED * delta


func _on_body_entered(body):
	if not can_kill:
		return

	if body is StaticBody2D:
		return

	if body.name.to_lower() == "player" and body.has_method("die"):
		body.die()
