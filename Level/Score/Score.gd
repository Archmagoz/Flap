extends Node2D

@onready var unit_sprite := $UnitSprite
@onready var ten_sprite := $TenSprite
@onready var hundred_sprite := $HundredSprite

var sprites: Array[Texture2D] = []

func _ready() -> void:
	for i in range(10):
		sprites.append(load("res://Level/Score/%d.png" % i))
		
	update_score_display()

func update_score_display() -> void:
	unit_sprite.texture = sprites[Game.score % 10]
	ten_sprite.texture = sprites[(Game.score / 10) % 10]
	hundred_sprite.texture = sprites[(Game.score / 100) % 10]
