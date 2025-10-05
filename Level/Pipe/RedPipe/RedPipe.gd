extends Area2D

var direction: int = -1

func _physics_process(_delta: float) -> void:
	position.x -= 120 * _delta
	position.y += 20 * direction * _delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		if body.is_alive:
			body.die()

func _on_lifetime_timeout() -> void:
	queue_free()
