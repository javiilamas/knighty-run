extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var power_up_bar: ProgressBar = $"../CanvasLayer/PowerUpBar"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Constants
const BASE_SPEED = 130.0                 # Base movement speed
const JUMP_VELOCITY = -250.0             # Jump strength
const RESPAWN_POSITION = Vector2(100, 100)
const FALL_LIMIT = 800                   

# Variables
var is_dead = false                       # True if player is currently dead
var speed_multiplier = 1.0                # Multiplier for speed power-ups


func _physics_process(delta: float) -> void:
	if is_dead:
		return # Skip movement while dead

	# Apply gravity if not on floor
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_stream_player_2d.play()

	# Move left/right
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Animation handling
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
		

	# Apply movement with speed multiplier
	var current_speed = BASE_SPEED * speed_multiplier
	if direction != 0:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()

	# Check if player fell out of the map
	if global_position.y > FALL_LIMIT:
		Global.score = 0
		die()


# Function to apply a speed boost for a certain duration
func apply_speed_boost(boost_amount: float, duration: float) -> void:
	speed_multiplier += boost_amount
	
	# Show and initialize the PowerUp bar
	if power_up_bar:
		power_up_bar.visible = true
		power_up_bar.value = 1.0

		# Create a tween to decrease bar value gradually
		var tween = create_tween()
		tween.tween_property(power_up_bar, "value", 0.0, duration)

	# Wait for the boost duration to end
	await get_tree().create_timer(duration).timeout
	
	# Reset speed back to normal
	speed_multiplier -= boost_amount

	# Hide the bar
	if power_up_bar:
		power_up_bar.visible = false


# Death function
func die():
	if is_dead:
		return
	is_dead = true

	animated_sprite_2d.play("dead")

	await get_tree().create_timer(2).timeout
	Global.score = 0
	global_position = RESPAWN_POSITION
	velocity = Vector2.ZERO
	is_dead = false
	
	
	
