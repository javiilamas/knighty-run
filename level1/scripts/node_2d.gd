extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var is_active: bool = false
var pop_time: float = 1.0  # how long spikes stay up

func _ready() -> void:
	collision.disabled = true
	timer.wait_time = 2.0  # time between trap activations
	timer.start()
	
func _on_Timer_timeout() -> void:
	if is_active:
		hide_trap()
	else:
		show_trap()

func show_trap() -> void:
	is_active = true
	collision.disabled = false
	sprite.play("pop_up") # play pop-up animation if you have one
	await get_tree().create_timer(pop_time).timeout
	hide_trap()

func hide_trap() -> void:
	is_active = false
	collision.disabled = true
	sprite.play("hide") # play hide animation if you have one

func _on_body_entered(body: Node) -> void:
	if is_active and body.name == "Player":
		body.take_damage() # call your player damage function
