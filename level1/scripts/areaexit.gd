extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name.to_lower() == "player" and body.has_method("die"):
		print("the player has enter the area exit")
