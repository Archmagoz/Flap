extends Node2D

const FLAP_SONG := preload("res://Player/Sounds/wing.ogg")
const HIT_SONG := preload("res://Player/Sounds/hit.ogg")
const POINT_SOUND := preload("res://Level/Sounds/point.ogg")

func play_sound(sound: AudioStream) -> void:
	var temp_player := AudioStreamPlayer2D.new()
	temp_player.stream = sound
	add_child(temp_player)
	
	temp_player.connect("finished", Callable(temp_player, "queue_free"))
	
	temp_player.play()

func flap() -> void:
	play_sound(FLAP_SONG)

func hit() -> void:
	play_sound(HIT_SONG)

func point() -> void:
	play_sound(POINT_SOUND)
