extends Control
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
func _ready() -> void:
	audio_stream_player_2d.play()
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Levels/world1.tscn")

func _on_quit_pressed():
	get_tree().quit()
