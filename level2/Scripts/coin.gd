extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var score_label: Label = $"../../Score/ScoreLabel"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var collected = false

func _on_body_entered(body: Node2D) -> void:
	if collected:
		return 
	
	if not body.is_in_group("player"):
		return
	
	collected = true
	Global.score +=1
	score_label.text = str(Global.score)
	audio_stream_player_2d.play()
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -30), 0.5)
	tween.tween_property(self , "modulate:a",0.0 ,0.5)
	
