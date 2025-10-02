extends Node2D

# Load the Sprite2D nodes
@onready var unit_sprite: Sprite2D = $UnitSprite
@onready var ten_sprite: Sprite2D = $TenSprite
@onready var hundred_sprite: Sprite2D = $HundredSprite

var sprites: Array[Texture2D] = []

# Instanciate all .png into sprites
func _ready() -> void:
	for i in range(10):
		sprites.append(load("res://Level/Score/%d.png" % i))
		
	update_score_display()

# Change the score image when needed @warning_ignore("integer_division") bua bua
func update_score_display() -> void:
	@warning_ignore("integer_division") unit_sprite.texture = sprites[Game.score % 10]
	@warning_ignore("integer_division") ten_sprite.texture = sprites[Game.score / 10 % 10]
	@warning_ignore("integer_division") hundred_sprite.texture = sprites[Game.score / 100 % 10]
