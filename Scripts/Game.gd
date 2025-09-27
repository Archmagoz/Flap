extends Node

const LEVEL := preload("res://Level/Level.tscn")
const GAMEOVER := preload("res://Gameover/Gameover.tscn")

func game_start() -> void:
	reset_score()
	get_tree().change_scene_to_packed(LEVEL)

func gameover() -> void:
	var gameover_scene := GAMEOVER.instantiate()
	get_tree().current_scene.add_child(gameover_scene)

var score: int = 0

func inc_score() -> void:
	score += 1

func reset_score() -> void:
	score = 0

func get_score() -> int:
	return score
