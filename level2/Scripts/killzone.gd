extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: CharacterBody2D) -> void:
		audio_stream_player_2d.play()
		Global.score = 0
		body.is_dead = true
		body.get_node("AnimatedSprite2D").play("die")
		await get_tree().create_timer(0.8).timeout  # laisse le temps à l’anim
		get_tree().reload_current_scene()
		

	
