extends Area2D

func _physics_process(_delta: float) -> void:
	position.x -= 100 * _delta

func _on_lifetime_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
