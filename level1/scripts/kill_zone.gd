extends Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D



@onready var timer: Timer = $Timer

func _on_body_entered(body) -> void:
		#Engine.time_scale=0.5
		#body.get_node("CollisionShape2d").queue_free()
		timer.start()
		audio_stream_player_2d.play()
		Global.score=0
		
	
func _on_timer_timeout() -> void :
	#Engine.time_scale=1
	get_tree().reload_current_scene() 
