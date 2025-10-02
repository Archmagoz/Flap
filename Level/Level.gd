extends Node2D

@onready var camera: Camera2D = $Camera
@onready var score: Node2D = $Score
@onready var pipe_spawnner: Timer = $PipeSpawnner

# Preload packed scenes and main components
const PIPE_SCENE: PackedScene = preload("res://Level/Pipe/Pipe.tscn")

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
	var pipe_down: Object = PIPE_SCENE.instantiate()
	var pipe_up: Object = PIPE_SCENE.instantiate()
	
	var min_y: float = cam_pos.y - screen_size.y / 2
	var max_y: float = cam_pos.y + screen_size.y / 2
	
	var random_y: float = randf_range(min_y + gap, max_y - gap)
	var spawn_x: float = cam_pos.x + screen_size.x / 2 + 50.0
	
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
		Game.inc_score()
		score.update_score_display()
		score_area.queue_free()
	) 
	
	return score_area
