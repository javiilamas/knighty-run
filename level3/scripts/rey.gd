extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_staff: AnimatedSprite2D = $staff/AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_salto: AudioStreamPlayer2D = $AudioStreamPlayer2D2

const SPEED = 130.0
const JUMP_VELOCITY = -250.0
const RESPAWN_POSITION = Vector2(0, 0)
const FALL_LIMIT = 800
var can_move: bool = true

var is_dead = false
var is_attacking = false
var has_sword = false

func _ready():
	animated_sprite_staff.visible = false
	$staff/CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		audio_stream_player_2d_salto.play()
		velocity.y = JUMP_VELOCITY
	# Handle attack (only if not already attacking)
	if Input.is_action_just_pressed("attack") and not is_attacking:
		
		attack()
	# Move
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
		$staff.scale.x = 1
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		$staff.scale.x = -1

	# Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		
		animated_sprite_2d.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Fall death
	if global_position.y > FALL_LIMIT:
		die()

func attack() -> void:
	if not has_sword:
		return
	
	if is_attacking:     # ⬅️ BLOQUEA ATAQUES EXTRA
		return
	
	if not is_on_floor():
		return

	is_attacking = true
	$staff/CollisionShape2D.disabled = false

	animated_sprite_staff.play("attack")

	await animated_sprite_staff.animation_finished

	is_attacking = false
	$staff/CollisionShape2D.disabled = true

func update_sword():
	animated_sprite_staff.visible = has_sword
	$staff/CollisionShape2D.disabled = not has_sword


func die():
	if is_dead:
		return
	is_dead = true

	print("Player died or fell!")
	audio_stream_player_2d.play()
	animated_sprite_2d.play("die")
	Global.score = 0
	
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

	global_position = RESPAWN_POSITION
	velocity = Vector2.ZERO
	is_dead = false


func _on_staff_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and is_attacking:
		
		body.queue_free()
	
