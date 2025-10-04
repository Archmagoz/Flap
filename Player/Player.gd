extends CharacterBody2D

# Load animation child node
@onready var animation: AnimatedSprite2D = $AnimatedSprite

# Some constants
const JUMP_VELOCITY: float = -300.0
const OWO: int = 3

# Player logic variables
var is_alive: bool = true
var angle: float = 0.5

# Start animation
func _ready() -> void:
	animation.play("fly")

# Process input
func _process(_delta: float) -> void:
	_handle_jump()

# Process the physics
func _physics_process(_delta: float) -> void:
	velocity += get_gravity() * _delta
	rotation = lerp(rotation, angle, OWO * _delta)

	move_and_slide()

# Handle the jump input
func _handle_jump() -> void:
	if is_alive:
		if Input.is_action_just_pressed("jump"):
			Sound.flap()
			velocity.y = JUMP_VELOCITY
			rotation += -0.75

# This is dark souls
func die() -> void:
	is_alive = false
	animation.stop()
	Sound.hit()
	Game.gameover()
