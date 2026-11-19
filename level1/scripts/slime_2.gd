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
	var player = get_tree().get_first_node_in_group("player")

	# --- IA simple de patrouille / poursuite ---
	if player:
		var dist_x = player.global_position.x - global_position.x
		var dist_y = abs(player.global_position.y - global_position.y)

		# Le slime ne poursuit le joueur que s'il est sur le même plan vertical (+/- 40 px)
		# et dans une certaine portée horizontale
		if abs(dist_x) < 400 and dist_y < 40:
			if dist_x > 0:
				direction = 1
				animated_sprite_2d.flip_h = false
			else:
				direction = -1
				animated_sprite_2d.flip_h = true

	# --- Collisions murs et sol ---
	if ray_cast_2d_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	elif ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true

	var has_floor_ahead = true
	if direction == 1 and not ray_cast_floor_right.is_colliding():
		has_floor_ahead = false
	elif direction == -1 and not ray_cast_floor_left.is_colliding():
		has_floor_ahead = false

	# --- Réaction au bord du sol ---
	if not has_floor_ahead:
		return

	# --- Mouvement normal ---
	position.x += direction * SPEED * delta




func _on_body_entered(body):
	if not can_kill:
		return

	if body is StaticBody2D:
		return

	if body.name.to_lower() == "player" and body.has_method("die"):
		body.die()
