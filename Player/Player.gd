extends CharacterBody2D

const JUMP_VELOCITY: float = -300.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite

# Logic variables
var is_alive: bool = true
var angle: float = 0.5

# Player init/start animation
func _ready() -> void:
	anim.play("fly")

# Player logic
func _physics_process(_delta: float) -> void:
	velocity += get_gravity() * _delta

	rotation = lerp(rotation, 0.5, 3 * _delta)

	if is_alive and Input.is_action_just_pressed("ui_accept"):
		Sound.flap()
		velocity.y = JUMP_VELOCITY
		rotation = -0.5

	move_and_slide()

# This is dark souls
func die() -> void:
	is_alive = false
	anim.stop()
	Game.gameover()
