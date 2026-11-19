extends Node2D

const SPEED = 40

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_floor_right: RayCast2D = $RayCastFloorRight
@onready var ray_cast_floor_left: RayCast2D = $RayCastFloorLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	# Change direction if there's no floor ahead
	if direction == 1 and not ray_cast_floor_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif direction == -1 and not ray_cast_floor_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	
	position.x += direction * SPEED * delta
