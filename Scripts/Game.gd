extends Node

# Preload packed scenes
const LEVEL: PackedScene = preload("res://Level/Level.tscn")
const GAMEOVER: PackedScene = preload("res://Gameover/Gameover.tscn")

# Game manager
func game_start() -> void:
	reset_score()
	get_tree().change_scene_to_packed(LEVEL)

func gameover() -> void:
	var gameover_scene: Object = GAMEOVER.instantiate()
	get_tree().current_scene.add_child(gameover_scene)

# Score manager
var score: int = 0

func inc_score() -> void:
	score += 1

func reset_score() -> void:
	score = 0
