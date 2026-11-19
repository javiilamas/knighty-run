extends Area2D

@onready var score_label: Label = $"../score/label"

const COST = 0

func _on_body_entered(body):
	print("entro")
	if body.name == "REY":

		if Global.score >= COST:
			# Restar monedas (si COST = 0 no pasa nada)
			Global.score -= COST
			score_label.text = str(Global.score)

			body.can_move = false

			# Eliminar el staff del nivel
			queue_free()

			body.can_move = true
			body.has_sword = true
			body.update_sword()

			
			
