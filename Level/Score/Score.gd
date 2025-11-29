extends Node2D

var score: int = 0

# Load the Sprite2D nodes
@onready var unit_sprite: Sprite2D = $UnitSprite
@onready var ten_sprite: Sprite2D = $TenSprite
@onready var hundred_sprite: Sprite2D = $HundredSprite

var sprites: Array[Texture2D] = [
	preload("res://Level/Score/0.png"),
	preload("res://Level/Score/1.png"),
	preload("res://Level/Score/2.png"),
	preload("res://Level/Score/3.png"),
	preload("res://Level/Score/4.png"),
	preload("res://Level/Score/5.png"),
	preload("res://Level/Score/6.png"),
	preload("res://Level/Score/7.png"),
	preload("res://Level/Score/8.png"),
	preload("res://Level/Score/9.png")
]

# Change the score image when needed @warning_ignore("integer_division") bua bua
func _update_score_display() -> void:
	@warning_ignore("integer_division") unit_sprite.texture = sprites[score % 10]
	@warning_ignore("integer_division") ten_sprite.texture = sprites[score / 10 % 10]
	@warning_ignore("integer_division") hundred_sprite.texture = sprites[score / 100 % 10]

# Update score
func inc_score() -> void:
	score += 1
	_update_score_display()

# Init
func _ready() -> void:
	_update_score_display()
