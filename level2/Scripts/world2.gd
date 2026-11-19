extends Node
@onready var score_label: Label = $Score/ScoreLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	score_label.text = str(Global.score)
	audio_stream_player_2d.play()
