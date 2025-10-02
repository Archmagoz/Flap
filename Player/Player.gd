extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite

const JUMP_VELOCITY: float = -300.0
const OWO: int = 3

# Logic variables
var is_alive: bool = true
var angle: float = 0.5

# Player init/start animation
func _ready() -> void:
	anim.play("fly")

# Player logic
func _physics_process(_delta: float) -> void:
	velocity += get_gravity() * _delta
	rotation = lerp(rotation, angle, OWO * _delta)

	_handle_jump()
	move_and_slide()

# This is dark souls
func die() -> void:
	is_alive = false
	anim.stop()
	Game.gameover()

# Pula boi pula cavalo
func _handle_jump() -> void:
	if is_alive:
		if Input.is_action_just_pressed("jump"):
			Sound.flap()
			velocity.y = JUMP_VELOCITY
			rotation += -0.75
