extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Connect the signal when something enters the Area2D
	area_2d.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	# Check if the body that touched us is the player
	if body.name.to_lower() == "player":
		# Make sure the player has a die() function
		if body.has_method("die"):
			body.die()
