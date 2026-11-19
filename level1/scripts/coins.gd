extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var collected=false

func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.name == "player":
		collected=true
		# Increase the global score
		Global.score += 1
		print(Global.score)
		
		# Play coin collection sound
		audio_stream_player_2d.play()
		
		# Create a tween to move the coin upwards and fade it out
		var tween = create_tween()
		tween.tween_property(self, "position", position + Vector2(0, -30), 0.25)  # move up
		tween.tween_property(self, "modulate:a", 0.0, 0.25)  # fade out
	
