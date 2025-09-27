extends CharacterBody2D

const JUMP_VELOCITY: float = -300.0

@onready var anim := $AnimatedSprite

var is_alive: bool = true
var angle: float = 0.5

func _ready() -> void:
	anim.play("fly")

func _physics_process(_delta: float) -> void:
	velocity += get_gravity() * _delta

	if velocity.y > 0:
		rotation += angle * _delta
	else:
		rotation = lerp(rotation, 0.5, 3 * _delta)

	if Input.is_action_just_pressed("ui_accept") and is_alive:
		Sound.flap()
		velocity.y = JUMP_VELOCITY
		rotation = -0.5

	move_and_slide()

func die() -> void:
	is_alive = false
	anim.stop()
	Game.gameover()
