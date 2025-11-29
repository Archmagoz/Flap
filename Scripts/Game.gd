extends Node

# Preload packed scenes
const LEVEL: PackedScene = preload("res://Level/Level.tscn")
const GAMEOVER: PackedScene = preload("res://Gameover/Gameover.tscn")

# Instanciate some utils
var rng: Object = RandomNumberGenerator.new()

# Game manager
func game_start() -> void:
	get_tree().change_scene_to_packed(LEVEL)

func gameover() -> void:
	var gameover_scene: Object = GAMEOVER.instantiate()
	get_tree().current_scene.add_child(gameover_scene)
