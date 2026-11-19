extends Area2D

@onready var score_label: Label = $"../Score/ScoreLabel"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const COST = 0  # Prix en pièces

func _on_body_entered(body):
	if body.is_in_group("player"):
		if Global.score >= COST:
			# Déduire les pièces
			Global.score -= COST
			score_label.text = str(Global.score)
			audio_stream_player_2d.play()
			body.can_move = false
			
			# Désactiver la power sword du monde
			await audio_stream_player_2d.finished
			body.can_move = true
			queue_free()
			
			# Donner l'épée
			body.has_sword = true
			body.update_sword()
			
			
			
			
			
			
			
			
			
			
			
