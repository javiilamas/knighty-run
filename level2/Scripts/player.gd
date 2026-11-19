extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite_sword: AnimatedSprite2D = $Sword/AnimatedSprite2D

var is_attacking = false
var has_sword = false
var can_move = true
var is_dead = false

func _ready():
	animated_sprite_sword.visible = false
	$Sword/CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	
	if is_dead:
		return
	
	if not can_move:
		return
		
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		audio_stream_player_2d.play()
		velocity.y = JUMP_VELOCITY
		
	# Handle attack (only if not already attacking)
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()

	# Handle flip (orientation)
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction > 0:
		animated_sprite.flip_h = false
		animated_sprite_sword.position.x = abs(animated_sprite_sword.position.x)
		animated_sprite_sword.rotation = abs(animated_sprite_sword.rotation)
		$Sword/CollisionShape2D.position.x = abs($Sword/CollisionShape2D.position.x)
		$Sword/CollisionShape2D.rotation = abs($Sword/CollisionShape2D.rotation)
		animated_sprite_sword.flip_h = false
	elif direction < 0:
		
		animated_sprite.flip_h = true
		animated_sprite_sword.position.x = -abs(animated_sprite_sword.position.x)
		animated_sprite_sword.rotation = -abs(animated_sprite_sword.rotation)
		$Sword/CollisionShape2D.position.x = -abs($Sword/CollisionShape2D.position.x)
		$Sword/CollisionShape2D.rotation = -abs($Sword/CollisionShape2D.rotation)
		animated_sprite_sword.flip_h = true
		

	# Handle movement animations
	if not is_attacking:
		if is_on_floor():
			if has_sword:
				animated_sprite_sword.visible = true
			if direction == 0:
				animated_sprite.play("idle")
				if has_sword:
					animated_sprite_sword.play("idle") #  sword idle quand player idle
			else:
				animated_sprite.play("run")
				if has_sword:
					animated_sprite_sword.play("idle") #  sword idle pendant la course
		else:
			if has_sword:
				animated_sprite_sword.visible = false
				animated_sprite_sword.play("idle") #  sword idle pendant le saut
			animated_sprite.play("jump")
			
	
	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func attack() -> void:
	if not has_sword:
		return
		
	if not is_on_floor():
		return
		
	is_attacking = true
	$Sword/CollisionShape2D.disabled = false
	animated_sprite_sword.play("attack")

	# Quand l'animation "attack" de la sword se termine :
	await animated_sprite_sword.animation_finished
	is_attacking = false
	$Sword/CollisionShape2D.disabled = true

func update_sword():
	animated_sprite_sword.visible = has_sword
	$Sword/CollisionShape2D.disabled = !has_sword

func _on_sword_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and is_attacking:
		body.queue_free()  # supprime l'ennemi
