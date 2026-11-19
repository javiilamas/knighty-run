extends CanvasLayer

func show_speed_quote():
	var label = Label.new()
	label.text = "SPEED UP"
	
	# Load and apply your custom pixel font
	var pixel_font = load("res://sprites/brackeys_platformer_assets/fonts/PixelOperator8-Bold.ttf")
	label.add_theme_font_override("font", pixel_font)
	
	# Font and style
	label.add_theme_font_size_override("font_size", 32)
	label.add_theme_color_override("font_color", Color.RED)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 2)

	# Position (above center, for example)
	label.anchor_left = 0.5
	label.anchor_top = 0.5
	label.anchor_right = 0.5
	label.anchor_bottom = 0.5
	label.position = Vector2(0, -150)

	add_child(label)

	# Animate fade-out
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 1.5)
	await tween.finished
	label.queue_free()
