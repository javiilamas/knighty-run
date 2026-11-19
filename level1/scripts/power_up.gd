extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed_boost: float = 0.5
var duration: float = 3.0

func _on_body_entered(body: Node) -> void:
	print("Collided with:", body.name)
	
	if body.name == "player":
		collision_shape_2d.disabled = true
		audio_stream_player_2d.play()

		if body.has_method("apply_speed_boost"):
			body.apply_speed_boost(speed_boost, duration)
			get_tree().current_scene.get_node("UI").show_speed_quote()


		var tween = create_tween()
		tween.tween_property(self, "position", position + Vector2(0, -30), 0.25)
		tween.tween_property(self, "modulate:a", 0.0, 0.25)
		tween.connect("finished", Callable(self, "queue_free"))
