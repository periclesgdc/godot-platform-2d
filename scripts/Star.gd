extends Area2D


signal collected


func _on_Star_body_entered(body):
	emit_signal("collected")
	queue_free()
