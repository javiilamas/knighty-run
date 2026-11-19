extends Node


@onready var music: AudioStreamPlayer2D = $Music

func play_music(stream: AudioStream):
	if music.stream == stream:
		return # déjà en train de jouer cette musique
	music.stream = stream
	music.play()
