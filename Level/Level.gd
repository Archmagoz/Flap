extends Node2D

const PIPE_SCENE: PackedScene = preload("res://Level/Pipe/Pipe.tscn")

@onready var camera: Camera2D = $Camera
@onready var sound: SoundComponent = $SoundComponent

var screen_size: Vector2
var cam_pos: Vector2
var gap: int

var score: int

func _ready() -> void:
	screen_size = get_viewport_rect().size / camera.zoom
	cam_pos = camera.global_position
	gap = 110

func _on_pipe_spawnner_timeout() -> void:
	var pipe_down: Node2D = PIPE_SCENE.instantiate()
	var pipe_up: Node2D = PIPE_SCENE.instantiate()
	
	var min_y: float = cam_pos.y - screen_size.y / 2
	var max_y: float = cam_pos.y + screen_size.y / 2
	
	var random_y: float = randf_range(min_y + gap, max_y - gap)
	var spawn_x: float = cam_pos.x + screen_size.x / 2 + 50.0
	
	pipe_down.position = Vector2(spawn_x, random_y)
	pipe_up.position = Vector2(spawn_x, random_y - gap)
	pipe_up.rotation_degrees = 180
	
	add_child(pipe_down)
	add_child(pipe_up)
