extends Node2D

@onready var camera: Camera2D = $Camera
@onready var score: Node2D = $Score
@onready var pipe_spawnner: Timer = $PipeSpawnner

# Preload packed scenes and main components
const PIPE_SCENE_GREEN: PackedScene = preload("res://Level/Pipe/GreenPipe/GreenPipe.tscn")
const PIPE_SCENE_RED: PackedScene = preload("res://Level/Pipe/RedPipe/RedPipe.tscn")

# Level logic variables
var screen_size: Vector2
var cam_pos: Vector2
var gap: int

# Init level logic
func _ready() -> void:
	screen_size = get_viewport_rect().size / camera.zoom
	cam_pos = camera.global_position
	gap = 100
	call_deferred("_on_pipe_spawnner_timeout")
	pipe_spawnner.start()

# Spawn random pipes with std gap
func _on_pipe_spawnner_timeout() -> void:
	var rand: int = Game.rng.randi_range(1, 10)
	
	var pipe_down: Object
	var pipe_up: Object
	
	var min_y: float = cam_pos.y - screen_size.y / 2
	var max_y: float = cam_pos.y + screen_size.y / 2
	
	var random_y: float = randf_range(min_y + gap, max_y - gap)
	var spawn_x: float = cam_pos.x + screen_size.x / 2 + 50.0
	
	if(rand <= 7):
		pipe_down = PIPE_SCENE_GREEN.instantiate()
		pipe_up = PIPE_SCENE_GREEN.instantiate()
	else:
		pipe_down = PIPE_SCENE_RED.instantiate()
		pipe_up = PIPE_SCENE_RED.instantiate()
		
	pipe_down.position = Vector2(spawn_x, random_y)
	pipe_up.position = Vector2(spawn_x, random_y - gap)
	pipe_up.rotation_degrees = 180
	
	pipe_down.add_child(add_score())
	
	add_child(pipe_down)
	add_child(pipe_up)

# Instanciate a score area between the pipes
func add_score() -> Area2D:
	var score_area: Object = Area2D.new()
	var collision: CollisionShape2D = CollisionShape2D.new()
	var shape: RectangleShape2D = RectangleShape2D.new()
	
	shape.extents = Vector2(5, gap / 2.0)
	collision.shape = shape
	collision.position = Vector2(0, -gap / 2.0)
	
	score_area.add_child(collision)
	
	score_area.body_exited.connect(func (_body: CharacterBody2D) -> void:
		Sound.point()
		score.inc_score()
		score_area.queue_free()
	) 
	
	return score_area
