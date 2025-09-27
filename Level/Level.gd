extends Node2D

const PIPE_SCENE := preload("res://Level/Pipe/Pipe.tscn")

@onready var camera := $Camera
@onready var pipe_spawnner := $PipeSpawnner
@onready var score := $Score

var screen_size: Vector2
var cam_pos: Vector2
var gap: int

func _ready() -> void:
	screen_size = get_viewport_rect().size / camera.zoom
	cam_pos = camera.global_position
	gap = 110
	call_deferred("_on_pipe_spawnner_timeout")
	pipe_spawnner.start()

func _on_pipe_spawnner_timeout() -> void:
	var pipe_down := PIPE_SCENE.instantiate()
	var pipe_up := PIPE_SCENE.instantiate()
	
	var min_y := cam_pos.y - screen_size.y / 2
	var max_y := cam_pos.y + screen_size.y / 2
	
	var random_y := randf_range(min_y + gap, max_y - gap)
	var spawn_x := cam_pos.x + screen_size.x / 2 + 50.0
	
	pipe_down.position = Vector2(spawn_x, random_y)
	pipe_up.position = Vector2(spawn_x, random_y - gap)
	pipe_up.rotation_degrees = 180
	
	pipe_down.add_child(add_score())
	
	add_child(pipe_down)
	add_child(pipe_up)

func add_score() -> Area2D:
	var score_area := Area2D.new()
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	
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
